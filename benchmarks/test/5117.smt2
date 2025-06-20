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

(declare-sort var1121 0)
(declare-sort var3746 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun rawParam/458914123 (var1121) String)
(declare-fun var3746_isNotEmpty/-1251449450 (String) Bool)
(declare-fun toString/-950398813 (var1121) String)
(declare-const null-var1121 var1121)
(declare-const var2512 var1121) ; Statement: r0 := @this: org.apache.dubbo.common.url.component.URLParam 
(assert (not (= var2512 null-var1121)))
(define-const var2345 String (rawParam/458914123 var2512)) ; Statement: $r1 = r0.<org.apache.dubbo.common.url.component.URLParam: java.lang.String rawParam> 
(define-const var2816 Bool (var3746_isNotEmpty/-1251449450 var2345)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto $r2 = virtualinvoke r0.<org.apache.dubbo.common.url.component.URLParam: java.lang.String toString()>() 
(assert (= (ite var2816 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var216 String (toString/-950398813 var2512)) ; Statement: $r2 = virtualinvoke r0.<org.apache.dubbo.common.url.component.URLParam: java.lang.String toString()>() 
 ; Statement: return $r2 
(check-sat)
; {rawParam/458914123=([org.apache.dubbo.common.url.component.URLParam], java.lang.String), var3746_isNotEmpty/-1251449450=([java.lang.String], boolean), toString/-950398813=([org.apache.dubbo.common.url.component.URLParam], java.lang.String)}
; {var1121=org.apache.dubbo.common.url.component.URLParam, var2512=r0, var2345=$r1, var3746=org.apache.dubbo.common.utils.StringUtils, var2816=$z0, var216=$r2}
; {org.apache.dubbo.common.url.component.URLParam=var1121, r0=var2512, $r1=var2345, org.apache.dubbo.common.utils.StringUtils=var3746, $z0=var2816, $r2=var216}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<org.apache.dubbo.common.url.component.URLParam: java.lang.String toString()>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.url.component.URLParam;	$r1 = r0.<org.apache.dubbo.common.url.component.URLParam: java.lang.String rawParam>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1);	if $z0 == 0 goto $r2 = virtualinvoke r0.<org.apache.dubbo.common.url.component.URLParam: java.lang.String toString()>();	$r2 = virtualinvoke r0.<org.apache.dubbo.common.url.component.URLParam: java.lang.String toString()>();	return $r2
;block_num 2