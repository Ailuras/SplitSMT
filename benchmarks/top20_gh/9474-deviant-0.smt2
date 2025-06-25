(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var3518 0)
(declare-sort var3056 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun substring/850833817 ((s String) (begin Int)) String (str.substr s begin (- (str.len s) begin)))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-String String)
(declare-const null-var3056 var3056)
(declare-const var3452 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3452 null-String)))
(define-const var907 Int 0) ; Statement: i6 = 0 
(assert true) ; Non Conditional
(assert true)
(define-const var3169 Int (length/-134980193 var3452)) ; Statement: $i0 = virtualinvoke r0.<java.lang.String: int length()>() 
 ; Statement: if i6 >= $i0 goto (branch) 
(assert (>= var907 var3169)) ; Cond: i6 >= $i0 
 ; Statement: if i6 != 0 goto $i1 = i6 - 1 
(assert (not (not (= var907 0)))) ; Negate: Cond: i6 != 0  
(define-const var2819 String "") ; Statement: $r6 = "" 
 ; Statement: goto [?= r1 = $r6] 
(assert true) ; Non Conditional
(define-const var2518 String var2819) ; Statement: r1 = $r6 
(define-const var1384 var3056 null-var3056) ; Statement: r7 = null 
(assert (not (and true (and (>= var907 0) (>= (str.len var3452) var907)))))
(check-sat)
; {length/-134980193=([java.lang.String], int), substring/850833817=([java.lang.String, int], java.lang.String), cast-from-Int-to-Int=([int], int)}
; {var3452=r0, var3518=null_type, var907=i6, var3169=$i0, var2819=$r6, var2518=r1, var3056=org.springframework.javapoet.ClassName, var1384=r7, var3152=$r2, var1418=$i9, var562=$r4, var1362=$i3, var3752=i7}
; {r0=var3452, null_type=var3518, i6=var907, $i0=var3169, $r6=var2819, r1=var2518, org.springframework.javapoet.ClassName=var3056, r7=var1384, $r2=var3152, $i9=var1418, $r4=var562, $i3=var1362, i7=var3752}
;seq <java.lang.String: int length()>;	<java.lang.String: java.lang.String substring(int)>;	<java.lang.String: java.lang.String[] split(java.lang.String,int)>
;cnt {"<java.lang.String: int length()>": 1,"<java.lang.String: java.lang.String substring(int)>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String,int)>": 1}
;stmts r0 := @parameter0: java.lang.String;	i6 = 0;	$i0 = virtualinvoke r0.<java.lang.String: int length()>();	if i6 >= $i0 goto (branch);	if i6 != 0 goto $i1 = i6 - 1;	$r6 = "";	goto [?= r1 = $r6];	r1 = $r6;	r7 = null;	$r2 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int)>(i6);	$i9 = (int) -1;	$r4 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("\\.", $i9);	$i3 = lengthof $r4;	i7 = 0;	if i7 >= $i3 goto return r7;	return r7
;block_num 7