{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{            Início do projeto 15/04/2024               }
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
        .GET('Listar todos', 'Listo todos os usuários')
          .AddResponse(201, 'lista de usuários encontrada com sucesso!')//Aqui passo a resposta do Path
            .Schema(TUsuario)//A resposta seria do objeto usuario
            .IsArray(True)//Como é um GET ALL passo um Array=True
      .&End
          .AddResponse(400).&End
          .AddResponse(404).&End
          .AddResponse(500).&End
    .&End
    .POST('Adicionar um novo usuario!')
      .AddParamBody('Dados do usuário')
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
        .GET('encontrar usuário por id')
          .AddParamPath('id', 'Id do Usuário')
            .Schema(SWAG_INTEGER)
          .&End
          .AddResponse(201, 'Registro encontrada com sucesso!').&End
          .AddResponse(400).&End//erro de validação
          .AddResponse(404).&End//id inválido
          .AddResponse(500).&End//erro banco de dados
    .&End
    .PUT('Update Usuário')
      .AddParamPath('Update usuario', 'id do Usuário')
        .Schema(SWAG_INTEGER)
      .&End
      .AddParamBody('usuario', 'Dados do Usuário')
        .Schema(TUsuario)
      .&End
      .AddResponse(204,'Alteração realizada com sucesso!').&End//sucesso na alteração
      .AddResponse(400).&End//erro de validação
      .AddResponse(404).&End//id inválido
      .AddResponse(500).&End//erro banco
    .&End
    .DELETE('Delete usuario')
      .AddParamPath('id', 'id do usuário')
        .Schema(SWAG_INTEGER)
    .&End
      .AddResponse(204,'Registro excluído com sucesso!').&End//sucesso na exclusão
      .AddResponse(400).&End//erro de validação
      .AddResponse(404).&End//id inválido
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
          .AddResponse(400).&End//erro de validação
          .AddResponse(404).&End//id inválido
          .AddResponse(500).&End//erro banco de dados
    .&End;
end;

end.
