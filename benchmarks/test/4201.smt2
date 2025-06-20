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

(declare-sort var3305 0)
(declare-sort var190 0)
(declare-sort var2580 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3305_getSystemProperty/1393069448 (String) String)
(declare-fun var190_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-const var2580-JAVA_8 var2580)
(define-const var1075 String (var3305_getSystemProperty/1393069448 "java.version")) ; Statement: r0 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("java.version") 
(define-const var3999 Bool (var190_isBlank/-523695098 (cast-from-String-to-String var1075))) ; Statement: z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0) 
 ; Statement: if z0 == 0 goto (branch) 
(assert (= (ite var3999 1 0) 0)) ; Cond: z0 == 0 
 ; Statement: if z0 != 0 goto $r2 = staticinvoke <java.lang.Runtime: java.lang.Runtime getRuntime()>() 
(assert (not (not (= (ite var3999 1 0) 0)))) ; Negate: Cond: z0 != 0  
(assert true)
(define-const var555 Bool (startsWith/-1785782452 var1075 "1.8")) ; Statement: $z1 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("1.8") 
 ; Statement: if $z1 == 0 goto $r2 = staticinvoke <java.lang.Runtime: java.lang.Runtime getRuntime()>() 
(assert (not (= (ite var555 1 0) 0))) ; Negate: Cond: $z1 == 0  
(define-const var3482 var2580 var2580-JAVA_8) ; Statement: $r22 = <org.apache.dubbo.common.utils.JRE: org.apache.dubbo.common.utils.JRE JAVA_8> 
 ; Statement: return $r22 
(check-sat)
; {var3305_getSystemProperty/1393069448=([java.lang.String], java.lang.String), var190_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean)}
; {var3305=org.apache.dubbo.common.utils.SystemPropertyConfigUtils, var1075=r0, var190=org.apache.dubbo.common.utils.StringUtils, var3999=z0, var555=$z1, var2580=org.apache.dubbo.common.utils.JRE, var3482=$r22}
; {org.apache.dubbo.common.utils.SystemPropertyConfigUtils=var3305, r0=var1075, org.apache.dubbo.common.utils.StringUtils=var190, z0=var3999, $z1=var555, org.apache.dubbo.common.utils.JRE=var2580, $r22=var3482}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>;	<java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1,"<java.lang.String: boolean startsWith(java.lang.String)>": 1}
;stmts r0 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("java.version");	z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0);	if z0 == 0 goto (branch);	if z0 != 0 goto $r2 = staticinvoke <java.lang.Runtime: java.lang.Runtime getRuntime()>();	$z1 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("1.8");	if $z1 == 0 goto $r2 = staticinvoke <java.lang.Runtime: java.lang.Runtime getRuntime()>();	$r22 = <org.apache.dubbo.common.utils.JRE: org.apache.dubbo.common.utils.JRE JAVA_8>;	return $r22
;block_num 4