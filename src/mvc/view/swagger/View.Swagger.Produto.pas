{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{            Início do projeto 19/04/2024               }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit View.Swagger.Produto;

interface

uses
  Horse.GBSwagger,
  Tabela.Swagger.Produto;
type
  TSwaggerProduto = class
   private
   public
     class procedure SwaggerProduto;
  end;

implementation

{ TSwaggerroduto }

class procedure TSwaggerProduto.SwaggerProduto;
begin

  Swagger
    .Path('produto')//nome do meu Path
      .Tag('produto')//agrupando meus Endpoint Tag do Path produto
        .GET('Listar todos', 'Listo todos os produtos')
          .AddResponse(201, 'lista de todos os produtos encontrado com sucesso!')//Aqui passo a resposta do Path
            .Schema(TProduto)//A resposta seria do objeto produto
            .IsArray(True)//Como é um GET ALL passo um Array=True
      .&End
          .AddResponse(400).&End
          .AddResponse(404).&End
          .AddResponse(500).&End
    .&End
    .POST('Adicionar um novo produto!')
      .AddParamBody('Dados do produto')
        .Schema(TProduto)
      .&End
          .AddResponse(201)
          .Schema(TProduto)
        .&End
          .AddResponse(400).&End
          .AddResponse(404).&End
          .AddResponse(500).&End
      .&End
    .&End
    .Path('produto/{id}')
      .Tag('produto')
        .GET('encontrar produto por id')
          .AddParamPath('id', 'Id do produto')
            .Schema(SWAG_INTEGER)
          .&End
          .AddResponse(201).&End
          .AddResponse(400).&End//erro de validação
          .AddResponse(404).&End//id inválido
          .AddResponse(500).&End//erro banco de dados
    .&End
    .PUT('Update produto')
      .AddParamPath('Update produto', 'id do produto')
        .Schema(SWAG_INTEGER)
      .&End
      .AddParamBody('produto', 'Dados da produto')
        .Schema(TProduto)
      .&End
      .AddResponse(204,'Alteração realizada com sucesso!').&End//sucesso na alteração
      .AddResponse(400).&End//erro de validação
      .AddResponse(404).&End//id inválido
      .AddResponse(500).&End//erro banco
    .&End
    .DELETE('Delete produto')
      .AddParamPath('id', 'id do produto')
        .Schema(SWAG_INTEGER)
    .&End
      .AddResponse(204,'Exclusão realizada com sucesso!').&End//sucesso na exclusão
      .AddResponse(400).&End//erro de validação
      .AddResponse(404).&End//id inválido
      .AddResponse(500).&End//erro banco
    .&End
    .&End
    .&End
    .Path('produto?nomeproduto')
      .Tag('produto')
        .GET('encontrar produto pelo nome do produto')
          .AddParamQuery('nomeproduto', 'Nome do Produto a ser filtrado')//, TSwagStringFormat.FormatString);
           .Schema(SWAG_STRING)
          .&End
          .AddResponse(201, 'Produto encontrado com sucesso!').&End
          .AddResponse(400).&End//erro de validação
          .AddResponse(404).&End//id inválido
          .AddResponse(500).&End//erro banco de dados
    .&End
    .&End
    .&End
    .Path('produto?ceantrib')
      .Tag('produto')
        .GET('encontrar produto por CeanTrib')
          .AddParamQuery('ceantrib','CeanTrib do produto')
           .Schema(SWAG_STRING)
          .&End
          .AddResponse(201, 'Produto encontrado com sucesso!').&End
          .AddResponse(400).&End//erro de validação
          .AddResponse(404).&End//id inválido
          .AddResponse(500).&End//erro banco de dados
    .&End
end;

end.
