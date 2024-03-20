class BoardListObject {
  String title;
  List<BoardItemObject> items;

  BoardListObject({required this.title, required this.items});
}

class BoardItemObject {
    String? id;

  String? idClass;
  String? title;
  String? description;
  String? explanationTitle;
  String? explanationDescription;
  String? status;

  BoardItemObject({ this.idClass, this. status, this.title,  this.description,  this.explanationTitle,  this.explanationDescription, this.id});
factory BoardItemObject.fromJson(Map<String, dynamic> json) {
  return BoardItemObject(
    id: json['ID']?.toString() ?? '',
    idClass: json['ID_CLASS']?.toString() ?? '',
    title: json['TITLE']?.toString() ?? '', 
    description: json['DESCRIPTION']?.toString() ?? '', 
    explanationTitle: json['EXPLANATION_TITLE']?.toString() ?? '',
    explanationDescription: json['EXPLANATION_DESCRIPTION'].toString(),
    status: json['status'].toString()
      );
}

Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idClass': idClass,
      'title': title,
      'description': description,
      'explanationTitle': explanationTitle,
      'explanationDescription': explanationDescription,
      'status': status,
    };
  }
}

class ActivitiesList {
  List<BoardItemObject> items = [BoardItemObject(title: "Tirar o lixo do chão da sala", description: "Você deve conferir se sua sala de aula está devidamente limpa - chão, mesas, cadeiras. Caso note embalagens, pedaços de papel, restos de comida ou de ponta de lápis, dê o seu melhor para descartá-los no lixo!", explanationTitle: "Por que jogar lixo no lixo?",explanationDescription: "Preservar a limpeza do nosso ambiente é tarefa de todos! É importante para aprendermos um pouco mais sobre nossas atitudes e responsabilidades."),
  BoardItemObject(title: "Recolher as tarefas de casa da turma", description: "Você deve pedir aos seus colegas para entregarem a você as tarefas de casa deles.  se sua sala de aula está devidamente limpa - chão, mesas, cadeiras. Caso não tenham tarefas de casa para o dia, marque a tarefa como concluída!", explanationTitle: "Por que recolher as tarefas de casa dos colegas?",explanationDescription: "Na vida, precisamos resolver muitas pendências em grupo. É importante que você aprenda a comunicar tarefas e combinar soluções junto com seus colegas!"),
  BoardItemObject(title: "Anotar quem faltou", description: "Você deve conferir se todos os seus colegas estão presente. Caso alguém esteja ausente, anote os nomes dos alunos e entregue à professora ao fim da aula! Caso todos estejam presentes, apenas marque a tarefa como concluída.", explanationTitle: "Por que marcar a falta dos meus colegas?",explanationDescription: "É importante aprender a diferenciar respostas erradas das corretas a partir da comparação."),
  BoardItemObject(title: "Ajudar na correção de atividades", description: "Você deve auxiliar a professora a corrigir as tarefas de casa de seus colegas.", explanationTitle: "Por que ajudar a corrigir atividades?",explanationDescription: "É importante aprender a ser transparente e sincero quanto às situações em que estamos inseridos."),

  ];
  

}