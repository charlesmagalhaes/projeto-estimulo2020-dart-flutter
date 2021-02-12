import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';



// ignore: non_constant_identifier_names
var USE_FIRESTORE_EMULATOR = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (USE_FIRESTORE_EMULATOR) {
    FirebaseFirestore.instance.settings = Settings(
        host: 'localhost:8080', sslEnabled: false, persistenceEnabled: false);
  }
runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App_estimulo2020',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
      @override
      _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
 
  GlobalKey<FormState> form = GlobalKey<FormState>();

  var db = FirebaseFirestore.instance;
  
  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController celularController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.deepPurple,
      
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [

              Text("Projeto Estímulo",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),textAlign: TextAlign.center,),

              SizedBox(
                width: 128,
                height: 128,
                child: Image.asset("imagens/estimulo2020.png"),
              ),

              TextFormField(
                controller: emailController,
                autofocus: true,
                keyboardType: TextInputType.emailAddress,
                style: new TextStyle(color: Colors.white, fontSize: 20),
                decoration: InputDecoration(
                  labelText: "E-mail",
                  labelStyle: TextStyle(color: Colors.white)
                ),
              ),

              Divider(),
   

              TextFormField(
                controller: senhaController,
                autofocus: true,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                style: new TextStyle(color: Colors.white, fontSize: 20),
                decoration: InputDecoration(
                  labelText: "Senha",
                  labelStyle: TextStyle(color: Colors.white)
                ),
              ),
             
              Container(
                height: 40,
                alignment: Alignment.centerRight,
                child: FlatButton(
                  child: Text(
                    "Recuperar senha",
                    textAlign: TextAlign.right,
                ),
                 onPressed:(){
                   Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return RecuperarSenha();
                  }
                   )
                   );
                 }
                ),
              ),
                ButtonTheme(
                height: 60.0,
                child: RaisedButton(
                  onPressed:() async {

                                // var db = FirebaseFirestore.instance;

                                // DocumentSnapshot resultado =
                                  //await db.collection("usuarios").doc().get();

                                  
                                      //print(resultado.id);
                                     // print(resultado.data);

                            

                                   Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      return Home();
                                     }));
   

                  },
                  child: Text(
                    "Login",
                    style: TextStyle(color:Colors.deepPurple, fontSize: 20), 
                  ),
                  color: Colors.white,
                ),
              ),
       
              Divider(),

                Container(
                height: 40,
                alignment: Alignment.topCenter,
                child: FlatButton(
                  child: Text(
                    "Cadastre-se",
                    textAlign: TextAlign.center, style: TextStyle(fontSize: 20),
                ),
                 onPressed:() => {
                  
                   showDialog(context: context,
                   builder: (BuildContext context){
                     return AlertDialog(
                       title: Text('Cadastro', textAlign: TextAlign.center,),
                       content: Form(
                         key: form,
                         child: Container(
                            height: MediaQuery.of(context).size.height/2,
                            child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: <Widget> [
                               Text('Nome Completo'),
                               TextFormField(
                                 decoration: InputDecoration(

                                   hintText: 'Nome Completo',
                                   border: OutlineInputBorder(
                                     borderRadius: BorderRadius.circular(15),
                                   )
                                 ),
                                 controller: nomeController,
                                 validator: (value){
                                   if (value.isEmpty){
                                     return 'Este campo não pode ficar vazio';
                                   }
                                   return null;
                                 },
                               ),
                              SizedBox(height: 20),
                              Text('E-mail'),
                              TextFormField(
                                 decoration: InputDecoration(

                                   hintText: 'email',
                                   border: OutlineInputBorder(
                                     borderRadius: BorderRadius.circular(15),
                                   )
                                 ),
                                 controller: emailController,
                                 validator: (value){
                                   if (value.isEmpty){
                                     return 'Este campo não pode ficar vazio';
                                   }
                                   return null;
                                 },
                               ),
                              SizedBox(height: 20),
                              Text('celular'),
                              TextFormField(
                                  decoration: InputDecoration(

                                   hintText: 'celular',
                                   border: OutlineInputBorder(
                                     borderRadius: BorderRadius.circular(15),
                                   )
                                 ),
                                 controller: celularController,
                                 validator: (value){
                                   if (value.isEmpty){
                                     return 'Este campo não pode ficar vazio';
                                   }
                                   return null;
                                 },
                               ),
                              SizedBox(height: 20),
                              Text('senha'),

                              TextFormField(
                                obscureText: true,
                                keyboardType: TextInputType.visiblePassword,
                                 decoration: InputDecoration(
                                 
                                   hintText: 'senha',
                                   border: OutlineInputBorder(
                                     borderRadius: BorderRadius.circular(15),
                                   )
                                 ),
                                 controller: senhaController,
                                 validator: (value){
                                   if (value.isEmpty){
                                     return 'Este campo não pode ficar vazio';
                                   }
                                   return null;
                                 },
                               ),

                             ],
                           ),
                         )),
                       actions: <Widget> [
                         FlatButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('Cancelar'),
                        ),
                        
                        FlatButton(
                          onPressed: () async {

                             var db = FirebaseFirestore.instance;

                                     if (form.currentState.validate()){


                                              db.collection("usuarios")
                                        
                                          
                                              .add(
                                                {
                                                  "celular": celularController.text,
                                                  "senha": senhaController.text,
                                                  "nome": nomeController.text,
                                                  "email": emailController.text,
                                                  "datadocadastro": Timestamp.now(),
                                                }
                                              )
                                               .then((value) => print("Usuário cadastrado"))
                                               .catchError((error) => print("Falha ao cadastrar o usuário: $error"));

                                           Navigator.of(context).pop();

                                     }
                                          
                                
                          },
                          color: Theme.of(context).buttonColor,
                          child: Text('Salvar'),
                        )
                       ],
                     );
                    }
                   ),
                 },
                ),
              ),
            ],
          ),
         ), 
        ),   
      );
  }
}

class CartoesArea extends StatelessWidget{
    final String curso;
    final int indice;

    CartoesArea(this.curso, this.indice);
    @override
    Widget build(BuildContext context) {
    return Center(
      
      child: Card(
        child: InkWell(
          
          splashColor: Colors.blue.withAlpha(100),
          onTap: () {
            if (indice == 1){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return Curso1();
                  }));
            }
              if (indice == 2){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return Curso2();
                  }));
            }
              if (indice == 3){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return Curso3();
                  }));
            }
              if (indice == 4){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return Curso4();
                  }));
            }
          },
          child: Container(
            width: 300,
            height: 100,
            child: ListTile( 
            hoverColor: Colors.green,
            leading:  Icon(Icons.bookmarks ),                     
            title: Text( this.curso), 
                                   
          ),
            
          ),
        ),
      ),
      
    );
  }

}

class CartoesCurso extends StatelessWidget{
    final String curso;
    final String url;

    CartoesCurso(this.curso, this.url);

  get index => null;
    @override
    Widget build(BuildContext context) {
    return Center(
      child: Card(
        child:
          Flexible(
            fit: FlexFit.tight,
            flex: 4,
              child: InkWell(
                splashColor: Colors.blue.withAlpha(100),
                onTap: () async {
                       await launch(url);
                },
                child: Container(
                width: 300,
                height: 100,
                child: ListTile( 
                     hoverColor: Colors.green,
                     leading:  Icon(Icons.movie ),                     
                    title: Text( this.curso), 
                    subtitle: Icon(Icons.play_arrow),                         
                                        
          ),
        ),
      ),
      ),
    ),
    );
  }
}

class Home extends StatefulWidget {
  HomeState createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  int _currentIndex = 0; 
  bool enviado;

 

  Widget callPage(int currentIndex){
    switch(currentIndex){

    
      case 0: return AreaCurso();
      case 1: return ListaConsultores();
      case 2: return Formulario();
      
        break;
      default: return AreaCurso();
      
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: callPage(_currentIndex),
      
       bottomNavigationBar: 
       BottomNavigationBar( 
          items: <BottomNavigationBarItem>[ 
        BottomNavigationBarItem( icon: Icon(Icons.home), 
          label: 'Cursos',    
           ), 
        BottomNavigationBarItem( icon: Icon(Icons.business), 
           label: 'Consultoria', 
            ), 
        BottomNavigationBarItem( icon: Icon(Icons.warning_rounded),
          label: 'Formulário',
        ), 
          ], 
             currentIndex: _currentIndex, 
             selectedItemColor: Colors.deepPurple, 
             onTap: (value){
               _currentIndex = value;
               setState(() {
               });
             }
        ),
    );
  }
}

class AreaCurso extends StatefulWidget {
  AreaCursoState createState() {
    return AreaCursoState();
  }
}

class AreaCursoState extends State<AreaCurso> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cursos por Area"), leading: Icon(Icons.home), ),
      body: Column(children: [
        CartoesArea('Area de gestão', 1),
        CartoesArea('Area de saude', 2),
        CartoesArea('Area de engenharia', 3),
        CartoesArea('Area de Tecnologia', 4),
       
      ]),
    );
  }
}

class Curso1 extends StatefulWidget {
  Curso1State createState() {
    return Curso1State();
  }
}

class Curso1State extends State<Curso1> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Videos dos Cursos"), ) ,
      body: Column(children: [
       
        CartoesCurso('Gestão de Processos','https://youtu.be/XBkbqVNRJwc'),
        CartoesCurso('Gestão de Projetos','https://youtu.be/mulzHJVCVFs'),
        CartoesCurso('Gestão Financeira', 'https://youtu.be/K69kwLhMAJM'),
        CartoesCurso('Gestão da Qualidade', 'https://youtu.be/Xny1AhkUrJM'),
       
      ]),
    );
  }
}

class Curso2 extends StatefulWidget {
  Curso2State createState() {
    return Curso2State();
  }
}

class Curso2State extends State<Curso2> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Videos dos Cursos"), ) ,
      body: Column(children: [
        CartoesCurso('Anatomia humana','https://youtu.be/5c3Pp-b7uwc'),
        CartoesCurso('Fisiologia do Exercício', 'https://youtu.be/qDI5kaxlRfg'),
        CartoesCurso('Bioquímica Celular','https://youtu.be/H2XiPZJlmY8'),
        CartoesCurso('Genética','https://youtu.be/2rqEmRrtkYc'),
       
      ]),
    );
  }
}

class Curso3 extends StatefulWidget {
  Curso3State createState() {
    return Curso3State();
  }
}


class Curso3State extends State<Curso3> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Videos dos Cursos"), ) ,
      body: Column(children: [
        CartoesCurso('Pontes','https://youtu.be/Nlfm-SQ1Msc'),
        CartoesCurso('Engenharia de barragens', 'https://youtu.be/CHIclQcYKkc'),
        CartoesCurso('Instalações Elétricas','https://youtu.be/u2OVhf6bA4w'),
        CartoesCurso('Mecânica dos fluidos','https://youtu.be/co2G8_0h-Ao'),
       
      ]),
    );
  }
}

class Curso4 extends StatefulWidget {
  Curso4State createState() {
    return Curso4State();
  }
}

class Curso4State extends State<Curso4> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Videos dos Cursos"), ) ,
      body: Column(children: [

        CartoesCurso('Gestão Agil','https://youtu.be/ds_FydzsuO8'),
        CartoesCurso('Flutter', 'https://youtu.be/jbAh5R8CH_o'),
        CartoesCurso('Sistemas Distribuidos','https://youtu.be/34RvRBXzvMo'),
        CartoesCurso('Scrum','https://youtu.be/XfvQWnRgxG0'),
       
      ]),
    );
  }
}



class CadastroLogin{

  String nome;
  String email;
  String celular;
  String senha;
 
}



class RecuperarSenha extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        
      ),
      body: Container(
        padding: EdgeInsets.only(
          top: 60,
          left: 40,
          right: 40,
        ),
        color: Colors.white,
        child: ListView(children: <Widget> [
          SizedBox(
            width: 200,
            height: 200,
            child: Icon(Icons.lock_rounded, size: 100,)
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Esqueceu sua senha?",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w500,
             ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Por gentileza, informe o e-mail associado a sua conta",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
             ),
             textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "E-mail",
                  labelStyle: TextStyle(
                                  color: Colors.black38,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                              ),
                  
                ),
              ),
          SizedBox(
            height: 20,
          ),
          ButtonTheme(
          height: 60.0,
          child:
          RaisedButton(
          onPressed: (){

                                
                    showDialog(context: context,
                   builder: (BuildContext context){
                     return AlertDialog(
                       title: Text('A senha foi enviada para o email cadastrado', textAlign:                                                   TextAlign.center,),
                
                       actions: <Widget> [
                         FlatButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('ok'),
                        ),

                       ],
                     );
                    }
                   );

          },
          child: new Text('Enviar', style: TextStyle(color:Colors.deepPurple, fontSize: 20)),
          color: Colors.white,
          )
          
          )
        ],
        ),
      ),
    );
  }
}

class Formulario extends StatefulWidget {
  @override
  FormularioState createState() => FormularioState();
}

class FormularioState extends State<Formulario> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  String nome, endereco, cidade, estado, celular, email;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
      primaryColor: Colors.deepPurple,
      ),
      home: new Scaffold(
        appBar: new AppBar(
            title: new Text('Formulário - Projeto Estímulo'),
            leading: Icon(Icons.book_online_rounded),
        ),
        body: new SingleChildScrollView(
          child: new Container(
            margin: new EdgeInsets.all(15.0),
            child: new Form(
              key: _key,
              // ignore: deprecated_member_use
              autovalidate: _validate,
              child: _formUI(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _formUI() {
    return new Padding(padding: EdgeInsets.all(10),
      child:   
    Column(
      children: <Widget>[

        Text("O objetivo deste formulário é realizar um mapeamento para posterior seleção de empresas contempladas no projeto ‘Consulte a Ânima’ de Assessoria/Consultoria do Centro Universitário Una e Centro Universitário Uni-BH.\n\n * O preenchimento do formulário não garante a participação no projeto ‘Consulte a Ânima’\n\n * Serão selecionadas 20 empresas.\n\n * O assessoramento terá a duração total de três (3) meses.\n\n * Todas as informações preenchidas neste formulário serão tratadas com confidencialidade.\n\n * Em caso de dúvidas, entrar em contato no endereço: sara.chaves@una.br\n\n * O preenchimento de todas as perguntas é obrigatório.\n\n Aceito participar do mapeamento ?",
            ),

                    TextField(
            autofocus: true,
            decoration:
            InputDecoration(border: 
            InputBorder.none,           
            hintText: 'Informe a razão social da empresa'),
          ),
                    
          TextField(
             autofocus: true,
             decoration:
             InputDecoration(border: 
             InputBorder.none,
             hintText: 'Informe o CNPJ'),
           ),
            
          TextField(
             autofocus: true,
             decoration:
             InputDecoration(border: 
             InputBorder.none,
             hintText: 'Informe o tempo de empresa'),          
           ),
            
          TextField(
             autofocus: true,
             decoration:
             InputDecoration(border: 
             InputBorder.none,
             hintText: 'O negócio é familiar?'), 
          ),

          Radiobutton(),        
        
          TextField(
             autofocus: true,
             decoration:
             InputDecoration(border: 
             InputBorder.none,
             hintText: 'Informe o endereço'),         
          ),
            
          TextField(
             autofocus: true,
             decoration:
             InputDecoration(border: 
             InputBorder.none,
             hintText: 'Informe a cidade'),
          ),
            
          TextField(
             autofocus: true,
             decoration:
             InputDecoration(border: 
             InputBorder.none,
             hintText: 'Informe o estado'),
          ),
            
          TextField(
             autofocus: true,
             decoration:
             InputDecoration(border: 
             InputBorder.none,
             hintText: 'Informe o telefone comercial'),
          ),
            
          TextField(
             autofocus: true,
             decoration:
             InputDecoration(border: 
             InputBorder.none,
             hintText: 'Informe o site / rede social da empresa (caso não tenha deixe em branco): '),
           ),
            
          TextField(
             autofocus: true,
             decoration:
             InputDecoration(border: 
             InputBorder.none,
             hintText: 'Informe o número de funcionarios antes da crise'),
          ),
            
          TextField(
             autofocus: true,
             decoration:
             InputDecoration(border: 
             InputBorder.none,
             hintText: 'Informe a faixa de faturamento mensal antes da crise'),
           
          ),
            
          TextField(
             autofocus: true,
             decoration:
             InputDecoration(border: 
             InputBorder.none,
             hintText: 'Qual é o setor de atuação da empresa?'),
            
          ),
            
          TextField(
             autofocus: true,
             decoration:
             InputDecoration(border: 
             InputBorder.none,
             hintText: 'Qual é a seguimentação de nicho de mercado da empresa?'),
            
          ),
            
          TextField(
             autofocus: true,
             decoration:
             InputDecoration(border: 
             InputBorder.none,
             hintText: 'Informe uma especialidade que você acredita necessitar de assessoria. (Ex: Contabilidade, E-commerce, financeiro, etc).'),
            
          ),
            
          TextField(
             autofocus: true,
             decoration:
             InputDecoration(border: 
             InputBorder.none,
             hintText: 'A sua empresa se beneficiou do programa emergencial de manutenção do emprego (Medida Provisória 936)?'),
            
          ),

          Radiobutton(),
          
         TextField(
             autofocus: true,
             decoration:
             InputDecoration(border: 
             InputBorder.none,
             hintText: 'A empresa recebeu algum empréstimo dos fundos públicos destinados ao socorro de pequenas e médias empresas \n\n afetadas pela Covid-19? (Exemplo: Programa Nacional de Apoio às Microempresas e Empresas de Pequeno Porte (Pronampe), Programa Emergencial de Suporte ao Emprego (Pese), Programa de Capital de Giro para Preservação de Empresa (CGPE), dentre outras).'),
            
           
          ),

          Radiobutton(),
        
          TextField(
             autofocus: true,
             decoration:
             InputDecoration(border: 
             InputBorder.none,
             hintText: 'Se você respondeu sim a pergunta anterior, informe qual(is) linha(s) de empréstimo(s) a empresa acessou e qual(is) o(s) valor(es) total(is) do(s) empréstimo(s) recebido(s)?'),
            
          ),
            
          TextField(
             autofocus: true,
             decoration:
             InputDecoration(border: 
             InputBorder.none,
             hintText: 'Durante a pandemia, quantos funcionários você demitiu?'),
            
          ),
            
          TextField(
             autofocus: true,
             decoration:
             InputDecoration(border: 
             InputBorder.none,
             hintText: 'Durante a pandemia, qual foi o percentual de redução de seu faturamento mensal?'),
            
          ),
            
          TextField(
             autofocus: true,
             decoration:
             InputDecoration(border: 
             InputBorder.none,
             hintText: 'Durante a pandemia, você precisou encerrar contrato com quantos fornecedores?'),
            
            
          ),
        new SizedBox(height: 15.0),
        new RaisedButton(
        onPressed: (){
          
               Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return PaginaAprovacao();
               }
               ));

        },
        child: new Text('Enviar'),
       )
      ]

    ),
    );
  }
}



class Radiobutton extends StatefulWidget {
  @override
  RadioButtonWidget createState() => RadioButtonWidget();
}

class RadioButtonWidget extends State<Radiobutton> {

  String radioItem = '';

  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[

          RadioListTile(
              groupValue: radioItem,
              title: Text('Sim'),
              value: 'Item 1',
              onChanged: (val) {
                setState(() {
                  radioItem = val;
                });
              },
            ),

           RadioListTile(
              groupValue: radioItem,
              title: Text('Não'),
              value: 'Item 2',
              onChanged: (val) {
                setState(() {
                  radioItem = val;
                });
              },
            ),

           RadioListTile(
              groupValue: radioItem,
              title: Text('Não sei'),
              value: 'Item 3',
              onChanged: (val) {
                setState(() {
                  radioItem = val;
                });
              },
            ),
          
           Text('$radioItem', style: TextStyle(fontSize: 23),)
          
        ],
    );
  }
}





class FormAcampanhamento extends StatefulWidget {
  @override
  FormAcampanhamentoState createState() =>FormAcampanhamentoState();
}

class FormAcampanhamentoState extends State<FormAcampanhamento> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  DateTime date = DateTime.now();
  double maxValue = 0;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acompanhamento - Mentoria'),
        leading: Icon(Icons.assignment_rounded),
      ),
      body: Form(
        key: _formKey,
        child: Scrollbar(
          child: Align(
            alignment: Alignment.topCenter,
            child: Card(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 400),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ...[
                        TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            hintText: 'Nome do curso',
                            labelText: 'Curso',
                          ),
                          onChanged: (value) {
                            setState(() {
                              title = value;
                            });
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            filled: true,
                            hintText: 'Descrição...',
                            labelText: 'Descreva sua experiência no curso',
                          ),
                          onChanged: (value) {
                            description = value;
                          },
                          maxLines: 5,
                        ),

                        ButtonTheme(
                                  height: 60.0,
                                  child:
                                  RaisedButton(
                                  onPressed: (){},
                                  child: new Text('Enviar', style: TextStyle(color:Colors.deepPurple, fontSize: 20)),
                                  color: Colors.white,
                                  ))

                      ].expand(
                        (widget) => [
                          widget,
                          SizedBox(
                            height: 24,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class ListaConsultores extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = "Lista de Consultores";
    return MaterialApp(
       theme: ThemeData(
      primaryColor: Colors.deepPurple,
      ),
      title: title,
      home: Scaffold(appBar: AppBar(
        leading: Icon(Icons.contact_page),
        title: Text(title),
        ),
        body: GridView.count(
          crossAxisCount: 2,
          children: List.generate(opcoes.length, (index) {
              return Center(
                child: OpcaoCard(opcao: opcoes[index]),
              );
           }
          )
        )
      )
    );
  }
}
class Opcao {
  const Opcao({this.titulo, this.icon});
  final String titulo;
  final IconData icon;
}
const List<Opcao> opcoes = const <Opcao>[
  const Opcao(titulo: 'Carlos Maia', icon: Icons.person),
  const Opcao(titulo: 'Luiz Gustavo', icon: Icons.person),
  const Opcao(titulo: 'Paulo André', icon: Icons.person),
  const Opcao(titulo: 'João Pedro', icon: Icons.person),
  const Opcao(titulo: 'José Maria', icon: Icons.person),
  const Opcao(titulo: 'Aline Silva', icon:Icons.person),
  const Opcao(titulo: 'Carla Andrade', icon: Icons.person),
  const Opcao(titulo: 'Janete Bolt', icon: Icons.person),

];


class OpcaoCard extends StatelessWidget {
  const OpcaoCard({Key key, this.opcao}) : super(key: key);
  final Opcao opcao;
  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context)
// ignore: deprecated_member_use
.textTheme.display1;
        return Card(
          color: Colors.deepPurple[50],
          child: Center(
             child: Column(
                 mainAxisSize: MainAxisSize.min,
                 crossAxisAlignment: CrossAxisAlignment.center,
                   children: <Widget>[
                Icon(opcao.icon, size:50.0, color: textStyle.color),
                Text(opcao.titulo, style: textStyle),

          ]
        ),
      )
    );
  }
}


class PaginaAprovacao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = "Formulário - Projeto Estímulo";
    return MaterialApp(
       theme: ThemeData(
      primaryColor: Colors.deepPurple,
      ),
      title: title,
      home: Scaffold(appBar: AppBar(
        leading: Icon(Icons.contact_page),
        title: Text(title),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
          
           child: Center(child:
        Column( children:  <Widget> [
           SizedBox(
            height: 20,
          ),
          Text("Seu formulário foi enviado com sucesso!!!"),
           SizedBox(
            height: 20,
          ),
          Divider(),
           SizedBox(
            height: 20,
          ),
          Text("Você poderá acompanhar seu processo nessa tela na parte Status"),
           SizedBox(
            height: 20,
          ),
          Divider(),
           SizedBox(
            height: 20,
          ),
          Card(
          color: Colors.deepPurple[50],
          child: Center(
             child: Column(
                 mainAxisSize: MainAxisSize.min,
                 crossAxisAlignment: CrossAxisAlignment.center,
                   children: <Widget>[

                     SizedBox(
                              height: 20,
                                ),
                      Text("Status:", style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,),),
                Text("Seu processo está em Análise", style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
             ),),

                        SizedBox(
                                  height: 20,
                                ),
                

                 ]
              ),
               )

          ),
           SizedBox(
            height: 50,
          ),

           Divider(),

            Text("Obs:.Enquanto isso você poderá assistir os cursos disponíveis na tela cursos"),
             Text("Obs:.A tela consultoria só será habilitada sua solicitação for aprovada "),

          ]  
          
          ,)
        )
        )
          ),
        );
  }
}