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

(declare-sort var1638 0)
(declare-sort var3227 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun rawParam/458914123 (var1638) String)
(declare-fun var3227_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var1638 var1638)
(declare-const var1313 var1638) ; Statement: r0 := @this: org.apache.dubbo.common.url.component.URLParam 
(assert (not (= var1313 null-var1638)))
(define-const var2406 String (rawParam/458914123 var1313)) ; Statement: $r1 = r0.<org.apache.dubbo.common.url.component.URLParam: java.lang.String rawParam> 
(define-const var3845 Bool (var3227_isNotEmpty/-1251449450 var2406)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto $r2 = virtualinvoke r0.<org.apache.dubbo.common.url.component.URLParam: java.lang.String toString()>() 
(assert (not (= (ite var3845 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1809 String (rawParam/458914123 var1313)) ; Statement: $r3 = r0.<org.apache.dubbo.common.url.component.URLParam: java.lang.String rawParam> 
 ; Statement: return $r3 
(check-sat)
; {rawParam/458914123=([org.apache.dubbo.common.url.component.URLParam], java.lang.String), var3227_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var1638=org.apache.dubbo.common.url.component.URLParam, var1313=r0, var2406=$r1, var3227=org.apache.dubbo.common.utils.StringUtils, var3845=$z0, var1809=$r3}
; {org.apache.dubbo.common.url.component.URLParam=var1638, r0=var1313, $r1=var2406, org.apache.dubbo.common.utils.StringUtils=var3227, $z0=var3845, $r3=var1809}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.url.component.URLParam;	$r1 = r0.<org.apache.dubbo.common.url.component.URLParam: java.lang.String rawParam>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1);	if $z0 == 0 goto $r2 = virtualinvoke r0.<org.apache.dubbo.common.url.component.URLParam: java.lang.String toString()>();	$r3 = r0.<org.apache.dubbo.common.url.component.URLParam: java.lang.String rawParam>;	return $r3
;block_num 2