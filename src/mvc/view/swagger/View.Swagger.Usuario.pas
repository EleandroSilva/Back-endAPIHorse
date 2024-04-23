{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{            In�cio do projeto 15/04/2024               }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit View.Swagger.Usuario;

interface

uses
  Horse.GBSwagger,
  Tabela.Swagger.Usuario;
type
  TSwaggerUsuario = class
   private
   public
     class procedure SwaggerUsuario;
  end;

implementation

{ TSwaggerEmpresa }

class procedure TSwaggerUsuario.SwaggerUsuario;
begin
  Swagger
    .Path('usuario')//nome do meu Path
      .Tag('usuario')//agrupando meus Endpoint Tag do Path empresa
        .GET('Listar todos', 'Listo todos os usu�rios')
          .AddResponse(201, 'lista de usu�rios encontrada com sucesso!')//Aqui passo a resposta do Path
            .Schema(TUsuario)//A resposta seria do objeto usuario
            .IsArray(True)//Como � um GET ALL passo um Array=True
      .&End
          .AddResponse(400).&End
          .AddResponse(404).&End
          .AddResponse(500).&End
    .&End
    .POST('Adicionar um novo usuario!')
      .AddParamBody('Dados do usu�rio')
        .Schema(TUsuario)
      .&End
          .AddResponse(201)
          .Schema(TUsuario)
        .&End
          .AddResponse(400).&End
          .AddResponse(404).&End
          .AddResponse(500).&End
      .&End
    .&End
    .Path('usuario/{id}')
      .Tag('usuario')
        .GET('encontrar usu�rio por id')
          .AddParamPath('id', 'Id do Usu�rio')
            .Schema(SWAG_INTEGER)
          .&End
          .AddResponse(201, 'Registro encontrada com sucesso!').&End
          .AddResponse(400).&End//erro de valida��o
          .AddResponse(404).&End//id inv�lido
          .AddResponse(500).&End//erro banco de dados
    .&End
    .PUT('Update Usu�rio')
      .AddParamPath('Update usuario', 'id do Usu�rio')
        .Schema(SWAG_INTEGER)
      .&End
      .AddParamBody('usuario', 'Dados do Usu�rio')
        .Schema(TUsuario)
      .&End
      .AddResponse(204,'Altera��o realizada com sucesso!').&End//sucesso na altera��o
      .AddResponse(400).&End//erro de valida��o
      .AddResponse(404).&End//id inv�lido
      .AddResponse(500).&End//erro banco
    .&End
    .DELETE('Delete usuario')
      .AddParamPath('id', 'id do usu�rio')
        .Schema(SWAG_INTEGER)
    .&End
      .AddResponse(204,'Registro exclu�do com sucesso!').&End//sucesso na exclus�o
      .AddResponse(400).&End//erro de valida��o
      .AddResponse(404).&End//id inv�lido
      .AddResponse(500).&End//erro banco
    .&End
    .&End
    .&End
    .Path('usuario?email e senha')
      .Tag('usuario')
        .GET('encontrar usuario por email e senha')
          .AddParamQuery('email','EMail')
          .&End
          .AddParamQuery('senha','Senha')
          .Schema(SWAG_STRING)
          .&End
          .AddResponse(201, 'Registro encontrada com sucesso!').&End
          .AddResponse(400).&End//erro de valida��o
          .AddResponse(404).&End//id inv�lido
          .AddResponse(500).&End//erro banco de dados
    .&End;
end;

end.
