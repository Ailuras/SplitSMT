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

(declare-sort var3649 0)
(declare-sort var634 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun rawParam/458914123 (var3649) String)
(declare-fun var634_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var3649 var3649)
(declare-const var2798 var3649) ; Statement: r0 := @this: org.apache.dubbo.common.url.component.URLParam 
(assert (not (= var2798 null-var3649)))
(define-const var2647 String (rawParam/458914123 var2798)) ; Statement: $r1 = r0.<org.apache.dubbo.common.url.component.URLParam: java.lang.String rawParam> 
(define-const var1757 Bool (var634_isNotEmpty/-1251449450 var2647)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto $r2 = r0.<org.apache.dubbo.common.url.component.URLParam: java.util.BitSet KEY> 
(assert (not (= (ite var1757 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1180 String (rawParam/458914123 var2798)) ; Statement: $r17 = r0.<org.apache.dubbo.common.url.component.URLParam: java.lang.String rawParam> 
 ; Statement: return $r17 
(check-sat)
; {rawParam/458914123=([org.apache.dubbo.common.url.component.URLParam], java.lang.String), var634_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var3649=org.apache.dubbo.common.url.component.URLParam, var2798=r0, var2647=$r1, var634=org.apache.dubbo.common.utils.StringUtils, var1757=$z0, var1180=$r17}
; {org.apache.dubbo.common.url.component.URLParam=var3649, r0=var2798, $r1=var2647, org.apache.dubbo.common.utils.StringUtils=var634, $z0=var1757, $r17=var1180}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.url.component.URLParam;	$r1 = r0.<org.apache.dubbo.common.url.component.URLParam: java.lang.String rawParam>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1);	if $z0 == 0 goto $r2 = r0.<org.apache.dubbo.common.url.component.URLParam: java.util.BitSet KEY>;	$r17 = r0.<org.apache.dubbo.common.url.component.URLParam: java.lang.String rawParam>;	return $r17
;block_num 2