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

(declare-sort var3761 0)
(declare-sort var1049 0)
(declare-sort var3101 0)
(declare-sort var646 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun toLowerCase/415700667 ((s String)) String (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all s "A" "a") "B" "b") "C" "c") "D" "d") "E" "e") "F" "f") "G" "g") "H" "h") "I" "i") "J" "j") "K" "k") "L" "l") "M" "m") "N" "n") "O" "o") "P" "p") "Q" "q") "R" "r") "S" "s") "T" "t") "U" "u") "V" "v") "W" "w") "X" "x") "Y" "y") "Z" "z"))
(declare-fun var1049_containsKey/1715618542 (var1049 var646) Bool)
(declare-fun cast-from-String-to-var646 (String) var646)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var3101-RANDOM_PORT_MAP var1049)
(declare-const var3675 String) ; Statement: r10 := @parameter0: java.lang.String 
(assert (not (= var3675 null-String)))
(declare-const var2482 Int) ; Statement: r1 := @parameter1: java.lang.Integer 
(assert (not (= var2482 null-Int)))
(assert true)
(define-const var768 String (toLowerCase/415700667 var3675)) ; Statement: r11 = virtualinvoke r10.<java.lang.String: java.lang.String toLowerCase()>() 
(define-const var3209 var1049 var3101-RANDOM_PORT_MAP) ; Statement: $r0 = <org.apache.dubbo.config.ServiceConfig: java.util.Map RANDOM_PORT_MAP> 
(define-const var2249 Bool (var1049_containsKey/1715618542 var3209 (cast-from-String-to-var646 var768))) ; Statement: $z0 = interfaceinvoke $r0.<java.util.Map: boolean containsKey(java.lang.Object)>(r11) 
 ; Statement: if $z0 != 0 goto return 
(assert (not (= (ite var2249 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: return 
(check-sat)
; {toLowerCase/415700667=([java.lang.String], java.lang.String), var1049_containsKey/1715618542=([java.util.Map, java.lang.Object], boolean), cast-from-String-to-var646=([java.lang.String], java.lang.Object)}
; {var3675=r10, var3761=null_type, var2482=r1, var768=r11, var1049=java.util.Map, var3101=org.apache.dubbo.config.ServiceConfig, var3209=$r0, var646=java.lang.Object, var2249=$z0}
; {r10=var3675, null_type=var3761, r1=var2482, r11=var768, java.util.Map=var1049, org.apache.dubbo.config.ServiceConfig=var3101, $r0=var3209, java.lang.Object=var646, $z0=var2249}
;seq <java.lang.String: java.lang.String toLowerCase()>
;cnt {"<java.lang.String: java.lang.String toLowerCase()>": 1}
;stmts r10 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.Integer;	r11 = virtualinvoke r10.<java.lang.String: java.lang.String toLowerCase()>();	$r0 = <org.apache.dubbo.config.ServiceConfig: java.util.Map RANDOM_PORT_MAP>;	$z0 = interfaceinvoke $r0.<java.util.Map: boolean containsKey(java.lang.Object)>(r11);	if $z0 != 0 goto return;	return
;block_num 2