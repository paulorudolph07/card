package br.com.bancoamazonia.card.web.converters;

import javax.faces.component.UIComponent;
import javax.faces.context.FacesContext;
import javax.faces.convert.Converter;
import javax.faces.convert.FacesConverter;

import org.springframework.web.jsf.FacesContextUtils;

import br.com.bancoamazonia.card.model.domain.SituacaoResidencial;
import br.com.bancoamazonia.card.service.SituacaoResidencialService;

@FacesConverter(value="situacaoResidencialConverter", forClass=SituacaoResidencial.class)
public class SituacaoResidencialConverter implements Converter {
	@Override
	public Object getAsObject(FacesContext context, UIComponent component, String value) {
		if(value != null)
			return FacesContextUtils.getWebApplicationContext(context).getBean(SituacaoResidencialService.class).get(new Byte(value));
		return null;
	}
	@Override
	public String getAsString(FacesContext context, UIComponent component, Object value) {
		if(value != null && value instanceof SituacaoResidencial)
			return ((SituacaoResidencial)value).getCodigo().toString();
		return null;
	}
}
