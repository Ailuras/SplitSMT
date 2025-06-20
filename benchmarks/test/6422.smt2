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

(declare-sort var1183 0)
(declare-sort var1336 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun toLowerCase/415700667 ((s String)) String (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all s "A" "a") "B" "b") "C" "c") "D" "d") "E" "e") "F" "f") "G" "g") "H" "h") "I" "i") "J" "j") "K" "k") "L" "l") "M" "m") "N" "n") "O" "o") "P" "p") "Q" "q") "R" "r") "S" "s") "T" "t") "U" "u") "V" "v") "W" "w") "X" "x") "Y" "y") "Z" "z"))
(declare-fun var1336_isSnakeCase/-534208988 (String) Bool)
(declare-const null-String String)
(declare-const var1260 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1260 null-String)))
(declare-const var3605 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var3605 null-String)))
(assert true)
(define-const var1066 String (toLowerCase/415700667 var1260)) ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String toLowerCase()>() 
(define-const var190 Bool (var1336_isSnakeCase/-534208988 var1260)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isSnakeCase(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto return r0 
(assert (= (ite var190 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return r0 
(check-sat)
; {toLowerCase/415700667=([java.lang.String], java.lang.String), var1336_isSnakeCase/-534208988=([java.lang.String], boolean)}
; {var1260=r0, var1183=null_type, var3605=r2, var1066=r1, var1336=org.apache.dubbo.common.utils.StringUtils, var190=$z0}
; {r0=var1260, null_type=var1183, r2=var3605, r1=var1066, org.apache.dubbo.common.utils.StringUtils=var1336, $z0=var190}
;seq <java.lang.String: java.lang.String toLowerCase()>;	<org.apache.dubbo.common.utils.StringUtils: boolean isSnakeCase(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String toLowerCase()>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isSnakeCase(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String toLowerCase()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isSnakeCase(java.lang.String)>(r0);	if $z0 == 0 goto return r0;	return r0
;block_num 2