(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (num_splits x d) limit)
         (num_splits x d)
         limit)
    (num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (num_splits x d) limit))
    (split_rest x d (- limit 1))
    (split_at x d i)
  )
)

(declare-sort var3059 0)
(declare-sort var2707 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(define-fun substring/850833817 ((s String) (begin Int)) String (str.substr s begin (- (str.len s) begin)))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-String String)
(declare-const null-var2707 var2707)
(declare-const var3633 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3633 null-String)))
(define-const var1354 Int 0) ; Statement: i6 = 0 
(assert true) ; Non Conditional
(assert true)
(define-const var1490 Int (length/-134980193 var3633)) ; Statement: $i0 = virtualinvoke r0.<java.lang.String: int length()>() 
 ; Statement: if i6 >= $i0 goto (branch) 
(assert (>= var1354 var1490)) ; Cond: i6 >= $i0 
 ; Statement: if i6 != 0 goto $i1 = i6 - 1 
(assert (not (= var1354 0))) ; Cond: i6 != 0 
(define-const var801 Int (- var1354 1)) ; Statement: $i1 = i6 - 1 
(assert (and true (and (>= 0 0) (>= (str.len var3633) var801) (>= var801 0))))
(define-const var3036 String (substring/-1240304868 var3633 0 var801)) ; Statement: $r6 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, $i1) 
(assert true) ; Non Conditional
(define-const var3776 String var3036) ; Statement: r1 = $r6 
(define-const var645 var2707 null-var2707) ; Statement: r7 = null 
(assert (and true (and (>= var1354 0) (>= (str.len var3633) var1354))))
(define-const var2843 String (substring/850833817 var3633 var1354)) ; Statement: $r2 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int)>(i6) 
(define-const var1841 Int (cast-from-Int-to-Int -1)) ; Statement: $i9 = (int) -1 
; split operation: var450 = var2843.split("\u005c.", var1841) ; Statement: $r4 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("\\.", $i9) 
(define-const var3759 Int (get_split_length var2843 "\u005c." var1841)) ; Statement: $i3 = lengthof $r4 
(define-const var103 Int 0) ; Statement: i7 = 0 
(assert true) ; Non Conditional
 ; Statement: if i7 >= $i3 goto return r7 
(assert (>= var103 var3759)) ; Cond: i7 >= $i3 
 ; Statement: return r7 
(check-sat)
; {length/-134980193=([java.lang.String], int), substring/-1240304868=([java.lang.String, int, int], java.lang.String), substring/850833817=([java.lang.String, int], java.lang.String), cast-from-Int-to-Int=([int], int)}
; {var3633=r0, var3059=null_type, var1354=i6, var1490=$i0, var801=$i1, var3036=$r6, var3776=r1, var2707=org.springframework.javapoet.ClassName, var645=r7, var2843=$r2, var1841=$i9, var450=$r4, var3759=$i3, var103=i7}
; {r0=var3633, null_type=var3059, i6=var1354, $i0=var1490, $i1=var801, $r6=var3036, r1=var3776, org.springframework.javapoet.ClassName=var2707, r7=var645, $r2=var2843, $i9=var1841, $r4=var450, $i3=var3759, i7=var103}
;seq <java.lang.String: int length()>;	<java.lang.String: java.lang.String substring(int,int)>;	<java.lang.String: java.lang.String substring(int)>;	<java.lang.String: java.lang.String[] split(java.lang.String,int)>
;cnt {"<java.lang.String: int length()>": 1,"<java.lang.String: java.lang.String substring(int,int)>": 1,"<java.lang.String: java.lang.String substring(int)>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String,int)>": 1}
;stmts r0 := @parameter0: java.lang.String;	i6 = 0;	$i0 = virtualinvoke r0.<java.lang.String: int length()>();	if i6 >= $i0 goto (branch);	if i6 != 0 goto $i1 = i6 - 1;	$i1 = i6 - 1;	$r6 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, $i1);	r1 = $r6;	r7 = null;	$r2 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int)>(i6);	$i9 = (int) -1;	$r4 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("\\.", $i9);	$i3 = lengthof $r4;	i7 = 0;	if i7 >= $i3 goto return r7;	return r7
;block_num 7
