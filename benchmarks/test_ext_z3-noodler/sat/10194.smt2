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

(declare-sort var588 0)
(declare-sort var2612 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var588 String) String)
(declare-fun var2612_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-var588 var588)
(declare-const var1702 var588) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1702 null-var588)))
(assert true)
(define-const var2316 String (getParameter/-1307325648 var1702 "provided-by")) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("provided-by") 
(define-const var1126 Bool (var2612_isBlank/-523695098 (cast-from-String-to-String var2316))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r1) 
 ; Statement: if $z0 == 0 goto $r2 = staticinvoke <org.apache.dubbo.metadata.AbstractServiceNameMapping: java.util.Set parseServices(java.lang.String)>(r1) 
(assert (not (= (ite var1126 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return null 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var2612_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var588=org.apache.dubbo.common.URL, var1702=r0, var2316=r1, var2612=org.apache.dubbo.common.utils.StringUtils, var1126=$z0}
; {org.apache.dubbo.common.URL=var588, r0=var1702, r1=var2316, org.apache.dubbo.common.utils.StringUtils=var2612, $z0=var1126}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.common.URL;	r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("provided-by");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r1);	if $z0 == 0 goto $r2 = staticinvoke <org.apache.dubbo.metadata.AbstractServiceNameMapping: java.util.Set parseServices(java.lang.String)>(r1);	return null
;block_num 2