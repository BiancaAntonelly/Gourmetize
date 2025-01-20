import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gourmetize/model/etiqueta.dart';
import 'package:gourmetize/model/receita.dart';
import 'package:gourmetize/provider/etiquetas_provider.dart';
import 'package:gourmetize/widgets/page_wrapper.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

import '../provider/auth_provider.dart';
import '../provider/receita_provider.dart';
import '../service/upload_service.dart';

class RegisterRevenueExtraProps {
  final Receita? receitaParaEdicao;

  const RegisterRevenueExtraProps({
    this.receitaParaEdicao,
  });
}

class RegisterRevenue extends StatefulWidget {
  final Receita? receitaParaEdicao;

  const RegisterRevenue({
    super.key,
    this.receitaParaEdicao,
  });
  @override
  _RegisterRevenueState createState() => _RegisterRevenueState();
}

class _RegisterRevenueState extends State<RegisterRevenue> {
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController ingredientesController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController preparoController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<Etiqueta> _etiquetas = [];
  final TextEditingController etiquetaController = TextEditingController();
  final TextEditingController youtubeIdController = TextEditingController();

  bool _isLoadingEtiquetas = true;

  File? _storedImage;
  String _imageUrl = '';
  
  get defaultValue => 0;

  @override
  void initState() {
    super.initState();

    Provider.of<EtiquetasProvider>(context, listen: false)
        .getEtiquetas(
      Provider.of<AuthProvider>(context, listen: false).usuarioLogado!.id,
    )
        .then((value) {
      setState(() {
        _isLoadingEtiquetas = false;
      });
    });

    if (widget.receitaParaEdicao != null) {
      tituloController.text = widget.receitaParaEdicao!.titulo;
      ingredientesController.text = widget.receitaParaEdicao!.ingredientes;
      descricaoController.text = widget.receitaParaEdicao!.descricao;
      preparoController.text = widget.receitaParaEdicao!.preparo;

      _etiquetas.addAll(widget.receitaParaEdicao!.etiquetas);
    }
  }

  void _addEtiqueta(String nome) async {
    if (nome.isEmpty) return;

    final usuarioLogado =
        Provider.of<AuthProvider>(context, listen: false).usuarioLogado;

    if (usuarioLogado == null) {
      // Se o usuário não estiver logado, mostramos uma mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuário não está logado.')),
      );
      return; // Não continua a criação da etiqueta
    }

    Etiqueta etiqueta = Etiqueta(nome: nome, usuario: usuarioLogado);

    final created = await Provider.of<EtiquetasProvider>(context, listen: false)
        .createEtiqueta(etiqueta);

    setState(() {
      _etiquetas.add(created);
    });

    etiquetaController.clear();
  }

  _takePicture() async {

    final usuarioLogado = Provider.of<AuthProvider>(context, listen: false).usuarioLogado;
    final ImagePicker _picker = ImagePicker();
    XFile imageFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    ) as XFile;

    if (imageFile == null) return;

    setState(() {
      _storedImage = File(imageFile.path);
    });

    //pegar pasta que posso salvar documentos
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    String fileName = path.basename(_storedImage!.path);
    
    final savedImage = await _storedImage!.copy(
      '${appDir.path}/$fileName',
    );

    if (_storedImage != null) {
      //final imageFile = File(fileName);
      final uploadService = UploadService();
      final String imageUrl = await uploadService.uploadImage(savedImage, usuarioLogado?.id ?? defaultValue);
      _imageUrl = imageUrl;
    } else {
      print('Nenhuma imagem foi selecionada.');
    }
  }

  Future<void> pickImageAndUpload() async {
    final ImagePicker picker = ImagePicker();
    final usuarioLogado = Provider.of<AuthProvider>(context, listen: false).usuarioLogado;

    try {
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

       if (pickedFile == null) return;

      setState(() {
        _storedImage = File(pickedFile.path);
      });

      // Obtém a pasta onde os arquivos podem ser salvos
      final appDir = await syspaths.getApplicationDocumentsDirectory();
      String fileName = path.basename(_storedImage!.path);

      final savedImage = await _storedImage!.copy(
        '${appDir.path}/$fileName',
      );

      if (_storedImage != null) {
        File imageFile = File(pickedFile.path);
        final uploadService = UploadService();
        final String imageUrl = await uploadService.uploadImage(imageFile, usuarioLogado?.id ?? defaultValue);
        _imageUrl = imageUrl;
      } else {
        print('Nenhuma imagem foi selecionada.');
      }
    } catch (e) {
      print('Erro ao selecionar imagem: $e');
    }
  }


  void _onSubmit() {
    final usuarioLogado =
        Provider.of<AuthProvider>(context, listen: false).usuarioLogado!;
    if (_formKey.currentState!.validate()) {
      Receita receita = Receita(
        id: widget.receitaParaEdicao?.id ?? 0,
        titulo: tituloController.text,
        descricao: descricaoController.text,
        ingredientes: ingredientesController.text,
        preparo: preparoController.text,
        usuario: usuarioLogado,
        imageUrl: _imageUrl,
        etiquetas: _etiquetas,
        youtubeId: youtubeIdController.text,
      );

      final receitaProvider =
          Provider.of<ReceitaProvider>(context, listen: false);

      if (widget.receitaParaEdicao != null) {
        receitaProvider.atualizarReceita(receita);
      } else {
        receitaProvider.adicionarReceita(receita);
      }

      context.pop(receita);
    }
  }

  @override
  Widget build(BuildContext context) {
    final etiquetas = Provider.of<EtiquetasProvider>(context).etiquetas;

    return PageWrapper(
      title:
          '${widget.receitaParaEdicao != null ? 'Editar' : 'Cadastrar'} Receita',
      pageWrapperButtonType: PageWrapperButtonType.back,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Título da receita:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: tituloController,
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    hintText: 'Digite o título da sua receita',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O título é obrigatório';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  'Ingredientes:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: ingredientesController,
                  style: TextStyle(fontSize: 16),
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText:
                        'Informe os ingredientes separados por uma quebra de linha',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Os ingredientes são obrigatórios';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  'Descrição:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: descricaoController,
                  maxLines: 4,
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    hintText:
                        'Informe uma breve descrição para ser mostrada na listagem de receitas',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'A descrição é obrigatória';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  'Modo de preparo:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: preparoController,
                  style: TextStyle(fontSize: 16),
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText:
                        'Informe o modo de preparo da sua receita separando os passos por uma quebra de linha',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O modo de preparo é obrigatório';
                    }
                    return null;
                  },
                ),
                Text(
                  'ID do Vídeo no YouTube:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: youtubeIdController,
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    hintText: 'Digite o ID do vídeo no YouTube',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2),
                    ),
                  ),
                  validator: (value) {
                    if (value != null && value.isNotEmpty && value.length != 11) {
                      return 'O ID do vídeo do YouTube deve ter 11 caracteres.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const SizedBox(height: 16),
                Text(
                  'Etiquetas:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                _isLoadingEtiquetas
                    ? Padding(
                        padding: EdgeInsets.all(8),
                        child: CircularProgressIndicator(),
                      )
                    : Wrap(
                        spacing: 8.0,
                        children: etiquetas.map((tag) {
                          final isSelected =
                              _etiquetas.indexWhere((e) => e.id == tag.id) !=
                                  -1;

                          return ChoiceChip(
                            label: Text(tag.nome),
                            selected: isSelected,
                            backgroundColor: Colors.white,
                            selectedColor:
                                Theme.of(context).colorScheme.primary,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            onSelected: (selected) {
                              setState(() {
                                selected
                                    ? _etiquetas.add(tag)
                                    : _etiquetas
                                        .removeWhere((e) => e.id == tag.id);
                              });
                            },
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 1,
                            ),
                          );
                        }).toList(),
                      ),
                if (!_isLoadingEtiquetas) const SizedBox(height: 8),
                if (!_isLoadingEtiquetas)
                  TextFormField(
                    controller: etiquetaController,
                    style: TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      hintText: 'Adicione uma etiqueta',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2),
                      ),
                    ),
                    onFieldSubmitted: _addEtiqueta,
                  ),
                const SizedBox(height: 24),
                const SizedBox(height: 8),
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: _storedImage != null
                      ? Image.file(
                          _storedImage!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        )
                      : Text(
                          'Selecione uma imagem',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _takePicture,
                      icon: Icon(Icons.camera),
                      label: Text('Tirar Foto'),
                    ),
                    ElevatedButton.icon(
                      onPressed: pickImageAndUpload,
                      icon: Icon(Icons.photo),
                      label: Text('Buscar na Galeria'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Center(
                    child: ElevatedButton(
                  onPressed: _onSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    widget.receitaParaEdicao == null
                        ? 'Cadastrar Receita'
                        : 'Atualizar Receita',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
