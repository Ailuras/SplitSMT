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

(declare-sort var3022 0)
(declare-sort var2355 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var2355-to-Int (var2355) Int)
(declare-fun String_valueOf/-333372740 (var2355) String)
(declare-fun cast-from-Int-to-var2355 (Int) var2355)
(declare-const null-var3022 var3022)
(declare-const null-var2355 var2355)
(declare-const var698 var3022) ; Statement: $r0 := @this: org.apache.dubbo.qos.command.util.ServiceCheckUtils$valueOf__911 
(assert (not (= var698 null-var3022)))
(declare-const var2600 var2355) ; Statement: $r1 := @parameter0: java.lang.Object 
(assert (not (= var2600 null-var2355)))
(define-const var239 Int (cast-from-var2355-to-Int var2600)) ; Statement: $r2 = (java.lang.Integer) $r1 
(define-const var1698 String (String_valueOf/-333372740 (cast-from-Int-to-var2355 var239))) ; Statement: $r3 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r2) 
 ; Statement: return $r3 
(check-sat)
; {cast-from-var2355-to-Int=([java.lang.Object], java.lang.Integer), String_valueOf/-333372740=([java.lang.Object], java.lang.String), cast-from-Int-to-var2355=([java.lang.Integer], java.lang.Object)}
; {var3022=org.apache.dubbo.qos.command.util.ServiceCheckUtils$valueOf__911, var698=$r0, var2355=java.lang.Object, var2600=$r1, var239=$r2, var1698=$r3}
; {org.apache.dubbo.qos.command.util.ServiceCheckUtils$valueOf__911=var3022, $r0=var698, java.lang.Object=var2355, $r1=var2600, $r2=var239, $r3=var1698}
;seq <java.lang.String: java.lang.String valueOf(java.lang.Object)>
;cnt {"<java.lang.String: java.lang.String valueOf(java.lang.Object)>": 1}
;stmts $r0 := @this: org.apache.dubbo.qos.command.util.ServiceCheckUtils$valueOf__911;	$r1 := @parameter0: java.lang.Object;	$r2 = (java.lang.Integer) $r1;	$r3 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r2);	return $r3
;block_num 1