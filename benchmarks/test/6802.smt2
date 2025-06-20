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

(declare-sort var1624 0)
(declare-sort var2102 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2102_isGeneric/-443667814 (String) Bool)
(define-fun equalsIgnoreCase/-92311102 ((this String) (another String)) Bool (let ((upper_this (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all this "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z")) (upper_another (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all another "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z"))) (= upper_this upper_another)))
(declare-const null-String String)
(declare-const var2091 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2091 null-String)))
(define-const var3137 Bool (var2102_isGeneric/-443667814 var2091)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.rpc.support.ProtocolUtils: boolean isGeneric(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $z2 = 0 
(assert (not (= (ite var3137 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2943 String "true") ; Statement: $r1 = "true" 
(assert true)
(define-const var2655 Bool (equalsIgnoreCase/-92311102 var2943 var2091)) ; Statement: $z1 = virtualinvoke $r1.<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>(r0) 
 ; Statement: if $z1 == 0 goto $z2 = 0 
(assert (= (ite var2655 1 0) 0)) ; Cond: $z1 == 0 
(define-const var1981 Bool (ite (= 1 0) true false)) ; Statement: $z2 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z2 
(check-sat)
; {var2102_isGeneric/-443667814=([java.lang.String], boolean), equalsIgnoreCase/-92311102=([java.lang.String, java.lang.String], boolean)}
; {var2091=r0, var1624=null_type, var2102=org.apache.dubbo.rpc.support.ProtocolUtils, var3137=$z0, var2943=$r1, var2655=$z1, var1981=$z2}
; {r0=var2091, null_type=var1624, org.apache.dubbo.rpc.support.ProtocolUtils=var2102, $z0=var3137, $r1=var2943, $z1=var2655, $z2=var1981}
;seq <java.lang.String: boolean equalsIgnoreCase(java.lang.String)>
;cnt {"<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.rpc.support.ProtocolUtils: boolean isGeneric(java.lang.String)>(r0);	if $z0 == 0 goto $z2 = 0;	$r1 = "true";	$z1 = virtualinvoke $r1.<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>(r0);	if $z1 == 0 goto $z2 = 0;	$z2 = 0;	return $z2
;block_num 4