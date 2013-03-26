package br.com.bancoamazonia.card.web.converters;

import javax.faces.component.UIComponent;
import javax.faces.context.FacesContext;
import javax.faces.convert.Converter;
import javax.faces.convert.FacesConverter;

import org.springframework.web.jsf.FacesContextUtils;

import br.com.bancoamazonia.card.model.domain.Estado;
import br.com.bancoamazonia.card.service.EstadoService;

@FacesConverter(value="estadoConverter", forClass=Estado.class)
public class EstadoConverter implements Converter {
	@Override
	public Object getAsObject(FacesContext context, UIComponent component, String value) {
		if(value != null)
			return FacesContextUtils.getWebApplicationContext(context).getBean(EstadoService.class).get(new Byte(value));
		return null;
	}
	@Override
	public String getAsString(FacesContext context, UIComponent component, Object value) {
		if(value != null && value instanceof Estado)
			return ((Estado)value).getId().toString();
		return null;
	}
}
