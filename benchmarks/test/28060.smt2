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

(declare-sort var2148 0)
(declare-sort var3920 0)
(declare-sort var3792 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var3920-to-String (var3920) String)
(declare-fun var3792_trim/1012475733 (String) String)
(declare-const null-var2148 var2148)
(declare-const null-var3920 var3920)
(declare-const var1540 var2148) ; Statement: $r0 := @this: org.apache.dubbo.common.extension.ExtensionLoader$trim__181 
(assert (not (= var1540 null-var2148)))
(declare-const var2990 var3920) ; Statement: $r1 := @parameter0: java.lang.Object 
(assert (not (= var2990 null-var3920)))
(define-const var3218 String (cast-from-var3920-to-String var2990)) ; Statement: $r2 = (java.lang.String) $r1 
(define-const var1811 String (var3792_trim/1012475733 var3218)) ; Statement: $r3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String trim(java.lang.String)>($r2) 
 ; Statement: return $r3 
(check-sat)
; {cast-from-var3920-to-String=([java.lang.Object], java.lang.String), var3792_trim/1012475733=([java.lang.String], java.lang.String)}
; {var2148=org.apache.dubbo.common.extension.ExtensionLoader$trim__181, var1540=$r0, var3920=java.lang.Object, var2990=$r1, var3218=$r2, var3792=org.apache.dubbo.common.utils.StringUtils, var1811=$r3}
; {org.apache.dubbo.common.extension.ExtensionLoader$trim__181=var2148, $r0=var1540, java.lang.Object=var3920, $r1=var2990, $r2=var3218, org.apache.dubbo.common.utils.StringUtils=var3792, $r3=var1811}
;seq <org.apache.dubbo.common.utils.StringUtils: java.lang.String trim(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: java.lang.String trim(java.lang.String)>": 1}
;stmts $r0 := @this: org.apache.dubbo.common.extension.ExtensionLoader$trim__181;	$r1 := @parameter0: java.lang.Object;	$r2 = (java.lang.String) $r1;	$r3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String trim(java.lang.String)>($r2);	return $r3
;block_num 1