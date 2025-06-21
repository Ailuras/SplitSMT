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

(declare-sort var1977 0)
(declare-sort var2395 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun isFile/1016913701 (var2395) Bool)
(declare-fun getName/1128186653 (var2395) String)
(define-fun toLowerCase/415700667 ((s String)) String (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all s "A" "a") "B" "b") "C" "c") "D" "d") "E" "e") "F" "f") "G" "g") "H" "h") "I" "i") "J" "j") "K" "k") "L" "l") "M" "m") "N" "n") "O" "o") "P" "p") "Q" "q") "R" "r") "S" "s") "T" "t") "U" "u") "V" "v") "W" "w") "X" "x") "Y" "y") "Z" "z"))
(declare-fun val$fileEnding/249748219 (var1977) String)
(define-fun endsWith/985337093 ((s String) (suffix String)) Bool (str.suffixof suffix s))
(declare-const null-var1977 var1977)
(declare-const null-var2395 var2395)
(declare-const var439 var1977) ; Statement: r2 := @this: org.antlr.v4.gui.TreeViewer$7 
(assert (not (= var439 null-var1977)))
(declare-const var483 var2395) ; Statement: r0 := @parameter0: java.io.File 
(assert (not (= var483 null-var2395)))
(assert true)
(define-const var1027 Bool (isFile/1016913701 var483)) ; Statement: $z0 = virtualinvoke r0.<java.io.File: boolean isFile()>() 
 ; Statement: if $z0 == 0 goto return 1 
(assert (not (= (ite var1027 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var2084 String (getName/1128186653 var483)) ; Statement: $r1 = virtualinvoke r0.<java.io.File: java.lang.String getName()>() 
(assert true)
(define-const var3967 String (toLowerCase/415700667 var2084)) ; Statement: $r4 = virtualinvoke $r1.<java.lang.String: java.lang.String toLowerCase()>() 
(define-const var3581 String (val$fileEnding/249748219 var439)) ; Statement: $r3 = r2.<org.antlr.v4.gui.TreeViewer$7: java.lang.String val$fileEnding> 
(assert true)
(define-const var1450 Bool (endsWith/985337093 var3967 var3581)) ; Statement: $z1 = virtualinvoke $r4.<java.lang.String: boolean endsWith(java.lang.String)>($r3) 
 ; Statement: return $z1 
(check-sat)
; {isFile/1016913701=([java.io.File], boolean), getName/1128186653=([java.io.File], java.lang.String), toLowerCase/415700667=([java.lang.String], java.lang.String), val$fileEnding/249748219=([org.antlr.v4.gui.TreeViewer$7], java.lang.String), endsWith/985337093=([java.lang.String, java.lang.String], boolean)}
; {var1977=org.antlr.v4.gui.TreeViewer$7, var439=r2, var2395=java.io.File, var483=r0, var1027=$z0, var2084=$r1, var3967=$r4, var3581=$r3, var1450=$z1}
; {org.antlr.v4.gui.TreeViewer$7=var1977, r2=var439, java.io.File=var2395, r0=var483, $z0=var1027, $r1=var2084, $r4=var3967, $r3=var3581, $z1=var1450}
;seq <java.lang.String: java.lang.String toLowerCase()>;	<java.lang.String: boolean endsWith(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String toLowerCase()>": 1,"<java.lang.String: boolean endsWith(java.lang.String)>": 1}
;stmts r2 := @this: org.antlr.v4.gui.TreeViewer$7;	r0 := @parameter0: java.io.File;	$z0 = virtualinvoke r0.<java.io.File: boolean isFile()>();	if $z0 == 0 goto return 1;	$r1 = virtualinvoke r0.<java.io.File: java.lang.String getName()>();	$r4 = virtualinvoke $r1.<java.lang.String: java.lang.String toLowerCase()>();	$r3 = r2.<org.antlr.v4.gui.TreeViewer$7: java.lang.String val$fileEnding>;	$z1 = virtualinvoke $r4.<java.lang.String: boolean endsWith(java.lang.String)>($r3);	return $z1
;block_num 2