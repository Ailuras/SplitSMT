(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var1184 0)
(declare-sort var2026 0)
(declare-sort var2080 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/506106603 (var2026 String String) String)
(declare-fun var2080_isNotEmpty/-1251449450 (String) Bool)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-const null-var1184 var1184)
(declare-const null-var2026 var2026)
(declare-const var2913 var1184) ; Statement: r4 := @this: org.apache.dubbo.common.config.configcenter.TreePathDynamicConfiguration 
(assert (not (= var2913 null-var1184)))
(declare-const var955 var2026) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var955 null-var2026)))
(assert true)
(define-const var2948 String (getParameter/506106603 var955 "dubbo.config-center.base-path" "/config")) ; Statement: r5 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("dubbo.config-center.base-path", "/config") 
(define-const var3891 Bool (var2080_isNotEmpty/-1251449450 var2948)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r5) 
 ; Statement: if $z0 == 0 goto return r5 
(assert (not (= (ite var3891 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var2829 Bool (startsWith/-1785782452 var2948 "/")) ; Statement: $z1 = virtualinvoke r5.<java.lang.String: boolean startsWith(java.lang.String)>("/") 
 ; Statement: if $z1 != 0 goto return r5 
(assert (not (= (ite var2829 1 0) 0))) ; Cond: $z1 != 0 
 ; Statement: return r5 
(check-sat)
; {getParameter/506106603=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var2080_isNotEmpty/-1251449450=([java.lang.String], boolean), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean)}
; {var1184=org.apache.dubbo.common.config.configcenter.TreePathDynamicConfiguration, var2913=r4, var2026=org.apache.dubbo.common.URL, var955=r0, var2948=r5, var2080=org.apache.dubbo.common.utils.StringUtils, var3891=$z0, var2829=$z1}
; {org.apache.dubbo.common.config.configcenter.TreePathDynamicConfiguration=var1184, r4=var2913, org.apache.dubbo.common.URL=var2026, r0=var955, r5=var2948, org.apache.dubbo.common.utils.StringUtils=var2080, $z0=var3891, $z1=var2829}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1,"<java.lang.String: boolean startsWith(java.lang.String)>": 1}
;stmts r4 := @this: org.apache.dubbo.common.config.configcenter.TreePathDynamicConfiguration;	r0 := @parameter0: org.apache.dubbo.common.URL;	r5 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("dubbo.config-center.base-path", "/config");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r5);	if $z0 == 0 goto return r5;	$z1 = virtualinvoke r5.<java.lang.String: boolean startsWith(java.lang.String)>("/");	if $z1 != 0 goto return r5;	return r5
;block_num 3