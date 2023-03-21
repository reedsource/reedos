package top.reed.common.core.domain;

import java.io.Serial;
import java.io.Serializable;
import java.util.List;

/**
 * CxSelect树结构实体类
 *
 * @author reedsource
 */
public class CxSelect implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 数据值字段名称
     */
    private String v;

    /**
     * 数据标题字段名称
     */
    private String n;

    /**
     * 子集数据字段名称
     */
    private List<CxSelect> s;

    public CxSelect() {
    }

    public CxSelect(String v, String n) {
        this.v = v;
        this.n = n;
    }

    public List<CxSelect> getS() {
        return s;
    }

    public void setS(List<CxSelect> s) {
        this.s = s;
    }

    public String getN() {
        return n;
    }

    public void setN(String n) {
        this.n = n;
    }

    public String getV() {
        return v;
    }

    public void setV(String v) {
        this.v = v;
    }
}
