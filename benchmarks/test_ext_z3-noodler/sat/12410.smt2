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

(declare-sort var2911 0)
(declare-sort var542 0)
(declare-sort var189 0)
(declare-sort var2320 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun name/1633728430 (var189) String)
(declare-fun cast-from-var542-to-var189 (var542) var189)
(declare-fun String_valueOf/-333372740 (var2320) String)
(declare-fun cast-from-String-to-var2320 (String) var2320)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(define-fun equalsIgnoreCase/-92311102 ((this String) (another String)) Bool (let ((upper_this (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all this "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z")) (upper_another (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all another "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z"))) (= upper_this upper_another)))
(declare-const null-String String)
(declare-const null-var542 var542)
(declare-const var2087 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2087 null-String)))
(declare-const var750 var542) ; Statement: r0 := @parameter1: org.apache.dubbo.qos.api.PermissionLevel 
(assert (not (= var750 null-var542)))
(assert true)
(define-const var1371 String (name/1633728430 (cast-from-var542-to-var189 var750))) ; Statement: $r4 = virtualinvoke r0.<org.apache.dubbo.qos.api.PermissionLevel: java.lang.String name()>() 
(define-const var1662 String (String_valueOf/-333372740 (cast-from-String-to-var2320 var2087))) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r1) 
(assert true)
(define-const var758 String (trim/-847153721 var1662)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.String: java.lang.String trim()>() 
(assert true)
(define-const var2812 Bool (equalsIgnoreCase/-92311102 var1371 var758)) ; Statement: $z0 = virtualinvoke $r4.<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>($r3) 
 ; Statement: return $z0 
(check-sat)
; {name/1633728430=([java.lang.Enum], java.lang.String), cast-from-var542-to-var189=([org.apache.dubbo.qos.api.PermissionLevel], java.lang.Enum), String_valueOf/-333372740=([java.lang.Object], java.lang.String), cast-from-String-to-var2320=([java.lang.String], java.lang.Object), trim/-847153721=([java.lang.String], java.lang.String), equalsIgnoreCase/-92311102=([java.lang.String, java.lang.String], boolean)}
; {var2087=r1, var2911=null_type, var542=org.apache.dubbo.qos.api.PermissionLevel, var750=r0, var189=java.lang.Enum, var1371=$r4, var2320=java.lang.Object, var1662=$r2, var758=$r3, var2812=$z0}
; {r1=var2087, null_type=var2911, org.apache.dubbo.qos.api.PermissionLevel=var542, r0=var750, java.lang.Enum=var189, $r4=var1371, java.lang.Object=var2320, $r2=var1662, $r3=var758, $z0=var2812}
;seq <java.lang.String: java.lang.String valueOf(java.lang.Object)>;	<java.lang.String: java.lang.String trim()>;	<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String valueOf(java.lang.Object)>": 1,"<java.lang.String: java.lang.String trim()>": 1,"<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>": 1}
;stmts r1 := @parameter0: java.lang.String;	r0 := @parameter1: org.apache.dubbo.qos.api.PermissionLevel;	$r4 = virtualinvoke r0.<org.apache.dubbo.qos.api.PermissionLevel: java.lang.String name()>();	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r1);	$r3 = virtualinvoke $r2.<java.lang.String: java.lang.String trim()>();	$z0 = virtualinvoke $r4.<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>($r3);	return $z0
;block_num 1