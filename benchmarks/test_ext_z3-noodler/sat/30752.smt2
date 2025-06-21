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

(declare-sort var1503 0)
(declare-sort var2024 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var2024-to-Int (var2024) Int)
(declare-fun String_valueOf/-333372740 (var2024) String)
(declare-fun cast-from-Int-to-var2024 (Int) var2024)
(declare-const null-var1503 var1503)
(declare-const null-var2024 var2024)
(declare-const var3273 var1503) ; Statement: $r0 := @this: org.apache.dubbo.qos.command.util.ServiceCheckUtils$valueOf__935 
(assert (not (= var3273 null-var1503)))
(declare-const var7 var2024) ; Statement: $r1 := @parameter0: java.lang.Object 
(assert (not (= var7 null-var2024)))
(define-const var3028 Int (cast-from-var2024-to-Int var7)) ; Statement: $r2 = (java.lang.Integer) $r1 
(define-const var3583 String (String_valueOf/-333372740 (cast-from-Int-to-var2024 var3028))) ; Statement: $r3 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r2) 
 ; Statement: return $r3 
(check-sat)
; {cast-from-var2024-to-Int=([java.lang.Object], java.lang.Integer), String_valueOf/-333372740=([java.lang.Object], java.lang.String), cast-from-Int-to-var2024=([java.lang.Integer], java.lang.Object)}
; {var1503=org.apache.dubbo.qos.command.util.ServiceCheckUtils$valueOf__935, var3273=$r0, var2024=java.lang.Object, var7=$r1, var3028=$r2, var3583=$r3}
; {org.apache.dubbo.qos.command.util.ServiceCheckUtils$valueOf__935=var1503, $r0=var3273, java.lang.Object=var2024, $r1=var7, $r2=var3028, $r3=var3583}
;seq <java.lang.String: java.lang.String valueOf(java.lang.Object)>
;cnt {"<java.lang.String: java.lang.String valueOf(java.lang.Object)>": 1}
;stmts $r0 := @this: org.apache.dubbo.qos.command.util.ServiceCheckUtils$valueOf__935;	$r1 := @parameter0: java.lang.Object;	$r2 = (java.lang.Integer) $r1;	$r3 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r2);	return $r3
;block_num 1