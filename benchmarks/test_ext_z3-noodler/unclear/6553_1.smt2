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

(declare-sort var3262 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun toLowerCase/415700667 ((s String)) String (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all s "A" "a") "B" "b") "C" "c") "D" "d") "E" "e") "F" "f") "G" "g") "H" "h") "I" "i") "J" "j") "K" "k") "L" "l") "M" "m") "N" "n") "O" "o") "P" "p") "Q" "q") "R" "r") "S" "s") "T" "t") "U" "u") "V" "v") "W" "w") "X" "x") "Y" "y") "Z" "z"))
(declare-fun replaceAll/1692887130 (String String String) String)
(declare-const null-String String)
(declare-const var1185 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1185 null-String)))
(assert true)
(define-const var2506 String (toLowerCase/415700667 var1185)) ; Statement: $r1 = virtualinvoke r0.<java.lang.String: java.lang.String toLowerCase()>() 
(assert true)
(define-const var2228 String (replaceAll/1692887130 var2506 "_|-" ".")) ; Statement: $r2 = virtualinvoke $r1.<java.lang.String: java.lang.String replaceAll(java.lang.String,java.lang.String)>("_|-", ".") 
(assert (= (replaceAll/1692887130 var2506 "_|-" ".") (str.replace_re_all var2506 (re.union (str.to_re "_") (str.to_re "-")) ".")))
 ; Statement: return $r2 
(check-sat)
; {toLowerCase/415700667=([java.lang.String], java.lang.String), replaceAll/1692887130=([java.lang.String, java.lang.String, java.lang.String], java.lang.String)}
; {var1185=r0, var3262=null_type, var2506=$r1, var2228=$r2}
; {r0=var1185, null_type=var3262, $r1=var2506, $r2=var2228}
;seq <java.lang.String: java.lang.String toLowerCase()>;	<java.lang.String: java.lang.String replaceAll(java.lang.String,java.lang.String)>
;cnt {"<java.lang.String: java.lang.String toLowerCase()>": 1,"<java.lang.String: java.lang.String replaceAll(java.lang.String,java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$r1 = virtualinvoke r0.<java.lang.String: java.lang.String toLowerCase()>();	$r2 = virtualinvoke $r1.<java.lang.String: java.lang.String replaceAll(java.lang.String,java.lang.String)>("_|-", ".");	return $r2
;block_num 1