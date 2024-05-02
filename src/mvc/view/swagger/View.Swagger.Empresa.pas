{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{            Início do projeto 15/04/2024               }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit View.Swagger.Empresa;

interface

uses
  Horse.GBSwagger,
  Entidade.Swagger.Empresa;
type
  TSwaggerEmpresa = class
   private
   public
     class procedure SwaggerEmpresa;
  end;

implementation

{ TSwaggerEmpresa }

class procedure TSwaggerEmpresa.SwaggerEmpresa;
begin
  Swagger
    .Path('empresa')//nome do meu Path
      .Tag('empresa')//agrupando meus Endpoint Tag do Path empresa
        .GET('Listar todas', 'Listo todas as empresas')
          .AddResponse(201, 'lista de empresa encontrada com sucesso!')//Aqui passo a resposta do Path
            .Schema(TEmpresa)//A resposta seria do objeto empresa
            .IsArray(True)//Como é um GET ALL passo um Array=True
      .&End
          .AddResponse(400).&End
          .AddResponse(404).&End
          .AddResponse(500).&End
    .&End
    .POST('Adicionar uma nova empresa!')
      .AddParamBody('Dados da empresa')
        .Schema(TEmpresa)
      .&End
          .AddResponse(201)
          .Schema(TEmpresa)
        .&End
          .AddResponse(400).&End
          .AddResponse(404).&End
          .AddResponse(500).&End
      .&End
    .&End
    .Path('empresa/{id}')
      .Tag('empresa')
        .GET('encontrar empresa por id')
          .AddParamPath('id', 'empresa id')
            .Schema(SWAG_INTEGER)
          .&End
          .AddResponse(201, 'Empresa encontrada com sucesso!').&End
          .AddResponse(400).&End//erro de validação
          .AddResponse(404).&End//id inválido
          .AddResponse(500).&End//erro banco de dados
    .&End
    .PUT('Update empresa')
      .AddParamPath('id', 'id da empresa')
        .Schema(SWAG_INTEGER)
          .&End
        .AddParamBody('empresa', 'Dados da empresa')
          .Schema(TEmpresa)
        .&End
        .AddResponse(204).&End//sucesso na exclusão
        .AddResponse(400).&End//erro de validação
        .AddResponse(404).&End//id inválido
        .AddResponse(500).&End//erro banco
    .&End
    .DELETE('Delete empresa')
      .AddParamPath('id', 'id da empresa')
        .Schema(SWAG_INTEGER)
    .&End
    .&End
    .&End
    .Path('empresa?cnpj')
      .Tag('empresa')
        .GET('encontrar empresa por cnpj')
          .AddParamQuery('cnpj', 'CNPJ da empresa a ser filtrada')//, TSwagStringFormat.FormatString);
           .Schema(SWAG_STRING)
          .&End
          .AddResponse(201, 'Empresa encontrada com sucesso!').&End
          .AddResponse(400).&End//erro de validação
          .AddResponse(404).&End//id inválido
          .AddResponse(500).&End//erro banco de dados
    .&End
    .&End
    .&End
    .Path('empresa?nomeempresarial')
      .Tag('empresa')
        .GET('encontrar empresa por Nome Empresarial')
          .AddParamQuery('nomeempresarial','Nome Empresarial')
           .Schema(SWAG_STRING)
          .&End
          .AddResponse(201, 'Empresa encontrada com sucesso!').&End
          .AddResponse(400).&End//erro de validação
          .AddResponse(404).&End//id inválido
          .AddResponse(500).&End//erro banco de dados
    .&End
end;

end.
