package br.com.bancoamazonia.card.web.converters;

import javax.faces.component.UIComponent;
import javax.faces.context.FacesContext;
import javax.faces.convert.Converter;
import javax.faces.convert.FacesConverter;

import org.springframework.web.jsf.FacesContextUtils;

import br.com.bancoamazonia.card.model.domain.EstadoCivil;
import br.com.bancoamazonia.card.service.EstadoCivilService;

@FacesConverter(value="estadoCivilConverter", forClass=EstadoCivil.class)
public class EstadoCivilConverter implements Converter {
	@Override
	public Object getAsObject(FacesContext context, UIComponent component, String value) {
		if(value != null)
			return FacesContextUtils.getWebApplicationContext(context).getBean(EstadoCivilService.class).get(new Byte(value));
		return null;
	}
	@Override
	public String getAsString(FacesContext context, UIComponent component, Object value) {
		if(value != null && value instanceof EstadoCivil)
			return ((EstadoCivil)value).getId().toString();
		return null;
	}
}
