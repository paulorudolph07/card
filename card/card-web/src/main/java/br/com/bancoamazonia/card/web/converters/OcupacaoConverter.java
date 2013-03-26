package br.com.bancoamazonia.card.web.converters;

import javax.faces.component.UIComponent;
import javax.faces.context.FacesContext;
import javax.faces.convert.Converter;
import javax.faces.convert.FacesConverter;

import org.springframework.web.jsf.FacesContextUtils;

import br.com.bancoamazonia.card.model.domain.Ocupacao;
import br.com.bancoamazonia.card.service.OcupacaoService;

@FacesConverter(value="ocupacaoConverter", forClass=Ocupacao.class)
public class OcupacaoConverter implements Converter {
	@Override
	public Object getAsObject(FacesContext context, UIComponent component, String value) {
		if(value != null)
			return FacesContextUtils.getWebApplicationContext(context).getBean(OcupacaoService.class).get(new Short(value));
		return null;
	}
	@Override
	public String getAsString(FacesContext context, UIComponent component, Object value) {
		if(value != null && value instanceof Ocupacao)
			return ((Ocupacao)value).getCodigo().toString();
		return null;
	}
}
