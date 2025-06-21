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

(declare-sort var3615 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun toUpperCase/1156088314 ((s String)) String (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all s "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z"))
(declare-fun replaceAll/1692887130 (String String String) String)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-const null-String String)
(declare-const var2897 String) ; Statement: r4 := @parameter0: java.lang.String 
(assert (not (= var2897 null-String)))
(assert true)
(define-const var1778 String (toUpperCase/1156088314 var2897)) ; Statement: $r0 = virtualinvoke r4.<java.lang.String: java.lang.String toUpperCase()>() 
(assert true)
(define-const var3334 String (replaceAll/1692887130 var1778 "\u005c." "_")) ; Statement: r5 = virtualinvoke $r0.<java.lang.String: java.lang.String replaceAll(java.lang.String,java.lang.String)>("\\.", "_") 
(assert (= (replaceAll/1692887130 var1778 "\u005c." "_") (str.replace_re_all var1778 (str.to_re ".") "_")))
(assert true)
(define-const var1296 Bool (startsWith/-1785782452 var3334 "DUBBO_")) ; Statement: $z0 = virtualinvoke r5.<java.lang.String: boolean startsWith(java.lang.String)>("DUBBO_") 
 ; Statement: if $z0 != 0 goto return r5 
(assert (not (= (ite var1296 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: return r5 
(check-sat)
; {toUpperCase/1156088314=([java.lang.String], java.lang.String), replaceAll/1692887130=([java.lang.String, java.lang.String, java.lang.String], java.lang.String), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean)}
; {var2897=r4, var3615=null_type, var1778=$r0, var3334=r5, var1296=$z0}
; {r4=var2897, null_type=var3615, $r0=var1778, r5=var3334, $z0=var1296}
;seq <java.lang.String: java.lang.String toUpperCase()>;	<java.lang.String: java.lang.String replaceAll(java.lang.String,java.lang.String)>;	<java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String toUpperCase()>": 1,"<java.lang.String: java.lang.String replaceAll(java.lang.String,java.lang.String)>": 1,"<java.lang.String: boolean startsWith(java.lang.String)>": 1}
;stmts r4 := @parameter0: java.lang.String;	$r0 = virtualinvoke r4.<java.lang.String: java.lang.String toUpperCase()>();	r5 = virtualinvoke $r0.<java.lang.String: java.lang.String replaceAll(java.lang.String,java.lang.String)>("\\.", "_");	$z0 = virtualinvoke r5.<java.lang.String: boolean startsWith(java.lang.String)>("DUBBO_");	if $z0 != 0 goto return r5;	return r5
;block_num 2