{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{            Início do projeto 15/04/2024               }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit View.Swagger.Fechar.Caixa;

interface

uses
  Horse.GBSwagger,
  Tabela.Swagger.Fechar.Caixa;
type
  TSwaggerFecharCaixa = class
   private
   public
     class procedure SwaggerFecharCaixa;
  end;

implementation

{ TSwaggerEmpresa }

class procedure TSwaggerFecharCaixa.SwaggerFecharCaixa;
begin
  Swagger
    .Path('fechar-caixa')//nome do meu Path
      .Tag('Fechar caixa')//agrupando meus Endpoint Tag do Path Fechar caixa
        .GET('Listar todos', 'Listo todos os caixas')
          .AddResponse(201, 'lista dos Fechar caixa encontrada com sucesso!')//Aqui passo a resposta do Path
            .Schema(TFecharCaixa)//A resposta seria do objeto CaixaDiario
            .IsArray(True)//Como é um GET ALL passo um Array=True
      .&End
          .AddResponse(400).&End
          .AddResponse(404).&End
          .AddResponse(500).&End
    .&End
    .POST('Adicionar um novo Fechar caixa!')
      .AddParamBody('Dados do Fechar caixa')
        .Schema(TFecharCaixa)
      .&End
          .AddResponse(201)
          .Schema(TFecharCaixa)
        .&End
          .AddResponse(400).&End
          .AddResponse(404).&End
          .AddResponse(500).&End
      .&End
    .&End
    .Path('fechar-caixa/{id}')
      .Tag('Fechar caixa')
        .GET('encontrar usuário por id')
          .AddParamPath('id', 'Id do Fechar caixa')
            .Schema(SWAG_INTEGER)
          .&End
          .AddResponse(201, 'Registro encontrada com sucesso!').&End
          .AddResponse(400).&End//erro de validação
          .AddResponse(404).&End//id inválido
          .AddResponse(500).&End//erro banco de dados
    .&End
    .PUT('Update fechar-caixa')
      .AddParamPath('Update Fechar caixa', 'id do Fechar caixa')
        .Schema(SWAG_INTEGER)
      .&End
      .AddParamBody('CaixaDiario', 'Dados do Fechar caixa')
        .Schema(TFecharCaixa)
      .&End
      .AddResponse(204,'Alteração realizada com sucesso!').&End//sucesso na alteração
      .AddResponse(400).&End//erro de validação
      .AddResponse(404).&End//id inválido
      .AddResponse(500).&End//erro banco
    .&End
    .DELETE('Delete fechar-caixa')
      .AddParamPath('id', 'id do Fechar caixa')
        .Schema(SWAG_INTEGER)
    .&End
      .AddResponse(204,'Registro excluído com sucesso!').&End//sucesso na exclusão
      .AddResponse(400).&End//erro de validação
      .AddResponse(404).&End//id inválido
      .AddResponse(500).&End//erro banco
    .&End
    .&End
    .&End
    .Path('fechar-caixa?nomeusuario')
      .Tag('Fechar caixa')
        .GET('encontrar Fechar caixa por Nome usuário')
          .AddParamQuery('nomeusuario','Nome usuário')
          .Schema(SWAG_STRING)
          .&End
          .AddResponse(201, 'Registro encontrada com sucesso!').&End
          .AddResponse(400).&End//erro de validação
          .AddResponse(404).&End//id inválido
          .AddResponse(500).&End//erro banco de dados
    .&End;
end;

end.
