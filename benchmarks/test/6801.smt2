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

(declare-sort var3270 0)
(declare-sort var2735 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2735_isGeneric/-443667814 (String) Bool)
(define-fun equalsIgnoreCase/-92311102 ((this String) (another String)) Bool (let ((upper_this (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all this "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z")) (upper_another (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all another "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z"))) (= upper_this upper_another)))
(declare-const null-String String)
(declare-const var321 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var321 null-String)))
(define-const var150 Bool (var2735_isGeneric/-443667814 var321)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.rpc.support.ProtocolUtils: boolean isGeneric(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $z2 = 0 
(assert (not (= (ite var150 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var648 String "true") ; Statement: $r1 = "true" 
(assert true)
(define-const var1448 Bool (equalsIgnoreCase/-92311102 var648 var321)) ; Statement: $z1 = virtualinvoke $r1.<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>(r0) 
 ; Statement: if $z1 == 0 goto $z2 = 0 
(assert (not (= (ite var1448 1 0) 0))) ; Negate: Cond: $z1 == 0  
(define-const var581 Bool (ite (= 1 1) true false)) ; Statement: $z2 = 1 
 ; Statement: goto [?= return $z2] 
(assert true) ; Non Conditional
 ; Statement: return $z2 
(check-sat)
; {var2735_isGeneric/-443667814=([java.lang.String], boolean), equalsIgnoreCase/-92311102=([java.lang.String, java.lang.String], boolean)}
; {var321=r0, var3270=null_type, var2735=org.apache.dubbo.rpc.support.ProtocolUtils, var150=$z0, var648=$r1, var1448=$z1, var581=$z2}
; {r0=var321, null_type=var3270, org.apache.dubbo.rpc.support.ProtocolUtils=var2735, $z0=var150, $r1=var648, $z1=var1448, $z2=var581}
;seq <java.lang.String: boolean equalsIgnoreCase(java.lang.String)>
;cnt {"<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.rpc.support.ProtocolUtils: boolean isGeneric(java.lang.String)>(r0);	if $z0 == 0 goto $z2 = 0;	$r1 = "true";	$z1 = virtualinvoke $r1.<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>(r0);	if $z1 == 0 goto $z2 = 0;	$z2 = 1;	goto [?= return $z2];	return $z2
;block_num 4