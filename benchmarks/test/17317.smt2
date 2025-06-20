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

(declare-sort var2 0)
(declare-sort var2942 0)
(declare-sort var3906 0)
(declare-sort var3707 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var2 String) String)
(declare-fun var2942_isNotBlank/-358081771 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var3707_emptyList/582664469 () var3906)
(declare-const null-var2 var2)
(declare-const var2204 var2) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var2204 null-var2)))
(assert true)
(define-const var3875 String (getParameter/-1307325648 var2204 "prefer.serialization")) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("prefer.serialization") 
(define-const var3604 Bool (var2942_isNotBlank/-358081771 (cast-from-String-to-String var3875))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotBlank(java.lang.CharSequence)>(r1) 
 ; Statement: if $z0 == 0 goto $r2 = staticinvoke <java.util.Collections: java.util.List emptyList()>() 
(assert (= (ite var3604 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3806 var3906 var3707_emptyList/582664469) ; Statement: $r2 = staticinvoke <java.util.Collections: java.util.List emptyList()>() 
 ; Statement: return $r2 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var2942_isNotBlank/-358081771=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var3707_emptyList/582664469=([], java.util.List)}
; {var2=org.apache.dubbo.common.URL, var2204=r0, var3875=r1, var2942=org.apache.dubbo.common.utils.StringUtils, var3604=$z0, var3906=java.util.List, var3707=java.util.Collections, var3806=$r2}
; {org.apache.dubbo.common.URL=var2, r0=var2204, r1=var3875, org.apache.dubbo.common.utils.StringUtils=var2942, $z0=var3604, java.util.List=var3906, java.util.Collections=var3707, $r2=var3806}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotBlank(java.lang.CharSequence)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.common.URL;	r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("prefer.serialization");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotBlank(java.lang.CharSequence)>(r1);	if $z0 == 0 goto $r2 = staticinvoke <java.util.Collections: java.util.List emptyList()>();	$r2 = staticinvoke <java.util.Collections: java.util.List emptyList()>();	return $r2
;block_num 2