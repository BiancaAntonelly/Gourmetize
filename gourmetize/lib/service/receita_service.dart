import 'dart:math';

import 'package:gourmetize/model/receita.dart';
import 'package:gourmetize/model/usuario.dart';
import 'package:gourmetize/model/avaliacao.dart';

class ReceitaService {
  final String _baseUrl = 'http://127.0.0.1:8080/receitas';

  Future<List<Receita>> buscarReceitas() async {
    // Mockado por enquanto
    List<Usuario> usuarios = [
      Usuario(
        id: Random().nextInt(10000),
        nome: 'Adisson',
        email: 'adisson@gmail.com',
        senha: 'password',
      ),
      Usuario(
        id: Random().nextInt(10000),
        nome: 'Bianca',
        email: 'bianca@gmail.com',
        senha: 'password',
      ),
      Usuario(
        id: Random().nextInt(10000),
        nome: 'Rodrigo',
        email: 'rodrigo@gmail.com',
        senha: 'password',
      ),
      Usuario(
        id: Random().nextInt(10000),
        nome: 'Maria',
        email: 'maria@gmail.com',
        senha: 'password',
      ),
    ];

    List<Receita> receitas = [
      Receita(
        id: Random().nextInt(10000),
        titulo: 'Bolo de chocolate',
        descricao: 'Bolo de cenoura com calda de chocolate delicioso!',
        ingredientes: 'Farinha\nOvos\nCenoura\nAçúcar\nLeite condensado',
        preparo: 'Faça a massa do bolo\nColoque no forno\nAguarde 30 min',
        usuario: usuarios[0],
        avaliacoes: [
          Avaliacao(
            nota: 5,
            comentario: 'Delicioso! Amei o bolo de chocolate.',
            usuario: usuarios[1],
          ),
          Avaliacao(
            nota: 4,
            comentario: 'Bolo fofinho e a calda é perfeita!',
            usuario: usuarios[2],
          ),
        ],
      ),
      Receita(
        id: Random().nextInt(10000),
        titulo: 'Torta de Limão',
        descricao: 'Torta com recheio cremoso de limão e base crocante.',
        ingredientes: 'Farinha\nManteiga\nLeite condensado\nLimão',
        preparo: 'Prepare a massa\nFaça o recheio de limão\nLeve à geladeira',
        usuario: usuarios[0],
        avaliacoes: [
          Avaliacao(
            nota: 5,
            comentario: 'A melhor torta de limão que já comi!',
            usuario: usuarios[2],
          ),
          Avaliacao(
            nota: 4,
            comentario: 'Muito saborosa, mas prefiro mais azedinha.',
            usuario: usuarios[1],
          ),
        ],
      ),
      Receita(
        id: Random().nextInt(10000),
        titulo: 'Pão de Queijo',
        descricao: 'Delicioso pão de queijo mineiro!',
        ingredientes: 'Polvilho\nOvos\nQueijo\nLeite\nÓleo',
        preparo: 'Misture os ingredientes\nForme bolinhas\nAsse por 25 min',
        usuario: usuarios[0],
        avaliacoes: [
          Avaliacao(
            nota: 5,
            comentario: 'Essa receita de pão de queijo é a melhor!',
            usuario: usuarios[2],
          ),
          Avaliacao(
            nota: 3,
            comentario: 'Achei bom, mas um pouco seco.',
            usuario: usuarios[1],
          ),
        ],
      ),
      Receita(
        id: Random().nextInt(10000),
        titulo: 'Bolo de Cenoura',
        descricao: 'Bolo de cenoura com cobertura de chocolate.',
        ingredientes: 'Cenoura\nFarinha\nAçúcar\nOvos\nÓleo',
        preparo: 'Misture tudo\nAsse por 40 min',
        usuario: usuarios[0],
        avaliacoes: [
          Avaliacao(
            nota: 3,
            comentario:
                'O bolo de cenoura estava bom, mas a calda não agradou.',
            usuario: usuarios[2],
          ),
          Avaliacao(
            nota: 4,
            comentario: 'Muito saboroso e fofinho!',
            usuario: usuarios[1],
          ),
        ],
      ),
      Receita(
        id: Random().nextInt(10000),
        titulo: 'Cookies de Chocolate',
        descricao: 'Cookies crocantes com pedaços de chocolate.',
        ingredientes: 'Farinha\nAçúcar\nManteiga\nChocolate\nOvos',
        preparo: 'Misture os ingredientes\nModele e asse por 12 min',
        usuario: usuarios[0],
        avaliacoes: [
          Avaliacao(
            nota: 5,
            comentario: 'Perfeito para um lanche rápido!',
            usuario: usuarios[1],
          ),
        ],
      ),
      Receita(
        id: Random().nextInt(10000),
        titulo: 'Pudim de Leite',
        descricao: 'Pudim cremoso de leite condensado.',
        ingredientes: 'Leite condensado\nLeite\nOvos\nAçúcar',
        preparo: 'Bata tudo e asse em banho-maria por 1h',
        usuario: usuarios[0],
        avaliacoes: [
          Avaliacao(
            nota: 5,
            comentario: 'Pudim maravilhoso!',
            usuario: usuarios[2],
          ),
          Avaliacao(
            nota: 4,
            comentario: 'Muito bom, mas um pouco doce para o meu gosto.',
            usuario: usuarios[1],
          ),
        ],
      ),

      // Receitas para usuario[1]
      Receita(
        id: Random().nextInt(10000),
        titulo: 'Risoto de Frango',
        descricao: 'Risoto cremoso com frango desfiado.',
        ingredientes: 'Arroz\nFrango\nCaldo de galinha\nQueijo\nCebola',
        preparo:
            'Cozinhe o arroz com caldo\nAdicione o frango\nFinalize com queijo',
        usuario: usuarios[1],
        avaliacoes: [
          Avaliacao(
            nota: 4,
            comentario: 'Muito bom, mas poderia ser um pouco mais salgado.',
            usuario: usuarios[2],
          )
        ],
      ),
      Receita(
        id: Random().nextInt(10000),
        titulo: 'Sopa de Legumes',
        descricao: 'Sopa nutritiva com vários legumes frescos.',
        ingredientes: 'Cenoura\nBatata\nChuchu\nAbóbora\nCaldo de carne',
        preparo:
            'Cozinhe todos os legumes\nBata metade no liquidificador\nMisture tudo',
        usuario: usuarios[1],
      ),
      Receita(
        id: Random().nextInt(10000),
        titulo: 'Salada de Frutas',
        descricao: 'Salada refrescante de frutas variadas.',
        ingredientes: 'Maçã\nBanana\nLaranja\nMamão\nManga',
        preparo: 'Pique as frutas\nMisture em uma tigela\nSirva gelado',
        usuario: usuarios[1],
      ),
      // Mais receitas para usuario[1]
      Receita(
        id: Random().nextInt(10000),
        titulo: 'Macarrão ao Molho Branco',
        descricao: 'Macarrão com um delicioso molho branco.',
        ingredientes: 'Macarrão\nLeite\nFarinha\nManteiga\nQueijo',
        preparo: 'Cozinhe o macarrão\nPrepare o molho e misture',
        usuario: usuarios[1],
      ),
      Receita(
        id: Random().nextInt(10000),
        titulo: 'Chili com Carne',
        descricao: 'Chili apimentado com carne e feijão.',
        ingredientes: 'Carne moída\nFeijão\nTomate\nCebola\nPimenta',
        preparo:
            'Cozinhe a carne\nAdicione os ingredientes e cozinhe por 30 min',
        usuario: usuarios[1],
      ),
      Receita(
        id: Random().nextInt(10000),
        titulo: 'Bolo de Banana',
        descricao: 'Bolo macio de banana com canela.',
        ingredientes: 'Banana\nFarinha\nOvos\nAçúcar\nCanela',
        preparo: 'Misture os ingredientes\nAsse por 30 min',
        usuario: usuarios[1],
      ),

      // Receitas para usuario[2]
      Receita(
        id: Random().nextInt(10000),
        titulo: 'Frango à Parmegiana',
        descricao: 'Frango empanado com molho de tomate e queijo.',
        ingredientes:
            'Peito de frango\nFarinha de rosca\nQueijo\nMolho de tomate',
        preparo:
            'Empane o frango\nFrite e coloque o molho e queijo\nAsse por 20 min',
        usuario: usuarios[2],
      ),
      Receita(
        id: Random().nextInt(10000),
        titulo: 'Lasanha de Carne',
        descricao: 'Lasanha recheada com carne moída e molho béchamel.',
        ingredientes: 'Massa de lasanha\nCarne moída\nQueijo\nMolho',
        preparo: 'Monte a lasanha\nAsse por 40 min',
        usuario: usuarios[2],
      ),
      Receita(
        id: Random().nextInt(10000),
        titulo: 'Quiche de Alho-Poró',
        descricao: 'Quiche deliciosa com recheio de alho-poró.',
        ingredientes: 'Massa\nAlho-poró\nCreme de leite\nQueijo',
        preparo: 'Prepare a massa\nRecheie e asse',
        usuario: usuarios[2],
      ),
      // Mais receitas para usuario[2]
      Receita(
        id: Random().nextInt(10000),
        titulo: 'Estrogonofe de Carne',
        descricao: 'Estrogonofe cremoso de carne com arroz.',
        ingredientes: 'Carne\nCreme de leite\nChampignon\nArroz',
        preparo: 'Cozinhe a carne\nAdicione os ingredientes e sirva com arroz',
        usuario: usuarios[2],
      ),
      Receita(
        id: Random().nextInt(10000),
        titulo: 'Tacos de Carne',
        descricao: 'Tacos recheados com carne moída e vegetais.',
        ingredientes: 'Tortilhas\nCarne moída\nAlface\nTomate\nQueijo',
        preparo: 'Recheie as tortilhas e sirva',
        usuario: usuarios[2],
      ),
      Receita(
        id: Random().nextInt(10000),
        titulo: 'Espaguete à Carbonara',
        descricao: 'Espaguete com molho cremoso de ovos e bacon.',
        ingredientes: 'Espaguete\nOvos\nQueijo\nBacon',
        preparo: 'Cozinhe o espaguete\nMisture com o molho',
        usuario: usuarios[2],
      )
    ];

    return receitas;
  }

  Future<void> adicionarReceita(Receita receita) async {
    // Implementar
  }

  Future<void> removerReceita(Receita receita) async {
    // Implementar
  }

  Future<void> atualizarReceita(Receita receita) async {
    // Implementar
  }
}
