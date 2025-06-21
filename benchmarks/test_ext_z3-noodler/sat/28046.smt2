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

(declare-sort var3788 0)
(declare-sort var2997 0)
(declare-sort var3652 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var2997-to-String (var2997) String)
(declare-fun var3652_isNotBlank/-358081771 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-var3788 var3788)
(declare-const null-var2997 var2997)
(declare-const var2610 var3788) ; Statement: $r0 := @this: org.apache.dubbo.common.extension.ExtensionLoader$isNotBlank__192 
(assert (not (= var2610 null-var3788)))
(declare-const var2326 var2997) ; Statement: $r1 := @parameter0: java.lang.Object 
(assert (not (= var2326 null-var2997)))
(define-const var780 String (cast-from-var2997-to-String var2326)) ; Statement: $r2 = (java.lang.String) $r1 
(define-const var1 Bool (var3652_isNotBlank/-358081771 (cast-from-String-to-String var780))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotBlank(java.lang.CharSequence)>($r2) 
 ; Statement: return $z0 
(check-sat)
; {cast-from-var2997-to-String=([java.lang.Object], java.lang.String), var3652_isNotBlank/-358081771=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var3788=org.apache.dubbo.common.extension.ExtensionLoader$isNotBlank__192, var2610=$r0, var2997=java.lang.Object, var2326=$r1, var780=$r2, var3652=org.apache.dubbo.common.utils.StringUtils, var1=$z0}
; {org.apache.dubbo.common.extension.ExtensionLoader$isNotBlank__192=var3788, $r0=var2610, java.lang.Object=var2997, $r1=var2326, $r2=var780, org.apache.dubbo.common.utils.StringUtils=var3652, $z0=var1}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotBlank(java.lang.CharSequence)>": 1}
;stmts $r0 := @this: org.apache.dubbo.common.extension.ExtensionLoader$isNotBlank__192;	$r1 := @parameter0: java.lang.Object;	$r2 = (java.lang.String) $r1;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotBlank(java.lang.CharSequence)>($r2);	return $z0
;block_num 1