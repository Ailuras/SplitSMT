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

(declare-sort var1969 0)
(declare-sort var3446 0)
(declare-sort var3379 0)
(declare-sort var697 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun toLowerCase/415700667 ((s String)) String (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all s "A" "a") "B" "b") "C" "c") "D" "d") "E" "e") "F" "f") "G" "g") "H" "h") "I" "i") "J" "j") "K" "k") "L" "l") "M" "m") "N" "n") "O" "o") "P" "p") "Q" "q") "R" "r") "S" "s") "T" "t") "U" "u") "V" "v") "W" "w") "X" "x") "Y" "y") "Z" "z"))
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun var3446_getOrDefault/-573460120 (var3446 var697 var697) var697)
(declare-fun cast-from-String-to-var697 (String) var697)
(declare-fun cast-from-Int-to-var697 (Int) var697)
(declare-fun cast-from-var697-to-Int (var697) Int)
(declare-const null-String String)
(declare-const var3379-RANDOM_PORT_MAP var3446)
(declare-const var2787 String) ; Statement: r4 := @parameter0: java.lang.String 
(assert (not (= var2787 null-String)))
(assert true)
(define-const var2908 String (toLowerCase/415700667 var2787)) ; Statement: r5 = virtualinvoke r4.<java.lang.String: java.lang.String toLowerCase()>() 
(define-const var114 var3446 var3379-RANDOM_PORT_MAP) ; Statement: $r0 = <org.apache.dubbo.config.ServiceConfig: java.util.Map RANDOM_PORT_MAP> 
(define-const var2829 Int (Int_valueOf/-1371140006 -2147483648)) ; Statement: $r1 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(-2147483648) 
(define-const var2793 var697 (var3446_getOrDefault/-573460120 var114 (cast-from-String-to-var697 var2908) (cast-from-Int-to-var697 var2829))) ; Statement: $r2 = interfaceinvoke $r0.<java.util.Map: java.lang.Object getOrDefault(java.lang.Object,java.lang.Object)>(r5, $r1) 
(define-const var1978 Int (cast-from-var697-to-Int var2793)) ; Statement: $r3 = (java.lang.Integer) $r2 
 ; Statement: return $r3 
(check-sat)
; {toLowerCase/415700667=([java.lang.String], java.lang.String), Int_valueOf/-1371140006=([int], java.lang.Integer), var3446_getOrDefault/-573460120=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-String-to-var697=([java.lang.String], java.lang.Object), cast-from-Int-to-var697=([java.lang.Integer], java.lang.Object), cast-from-var697-to-Int=([java.lang.Object], java.lang.Integer)}
; {var2787=r4, var1969=null_type, var2908=r5, var3446=java.util.Map, var3379=org.apache.dubbo.config.ServiceConfig, var114=$r0, var2829=$r1, var697=java.lang.Object, var2793=$r2, var1978=$r3}
; {r4=var2787, null_type=var1969, r5=var2908, java.util.Map=var3446, org.apache.dubbo.config.ServiceConfig=var3379, $r0=var114, $r1=var2829, java.lang.Object=var697, $r2=var2793, $r3=var1978}
;seq <java.lang.String: java.lang.String toLowerCase()>
;cnt {"<java.lang.String: java.lang.String toLowerCase()>": 1}
;stmts r4 := @parameter0: java.lang.String;	r5 = virtualinvoke r4.<java.lang.String: java.lang.String toLowerCase()>();	$r0 = <org.apache.dubbo.config.ServiceConfig: java.util.Map RANDOM_PORT_MAP>;	$r1 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(-2147483648);	$r2 = interfaceinvoke $r0.<java.util.Map: java.lang.Object getOrDefault(java.lang.Object,java.lang.Object)>(r5, $r1);	$r3 = (java.lang.Integer) $r2;	return $r3
;block_num 1