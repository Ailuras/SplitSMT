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

(declare-sort var3147 0)
(declare-sort var1185 0)
(declare-sort var3985 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3147 var3147)
(declare-const null-var1185 var1185)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const var1846 var3147) ; Statement: r3 := @this: org.antlr.v4.codegen.Target 
(assert (not (= var1846 null-var3147)))
(declare-const var672 var1185) ; Statement: r5 := @parameter0: org.antlr.v4.codegen.CodeGenerator 
(assert (not (= var672 null-var1185)))
(declare-const var3816 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var3816 null-String)))
(declare-const var3655 Bool) ; Statement: z0 := @parameter2: boolean 
(assert (not (= var3655 null-Bool)))
(declare-const var970 Bool) ; Statement: z2 := @parameter3: boolean 
(assert (not (= var970 null-Bool)))
(define-const var230 String String-init) ; Statement: $r6 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var230)) ; Statement: specialinvoke $r6.<java.lang.StringBuilder: void <init>()>() 
(declare-const var230!1 String)
(assert (= var230!1 ""))
 ; Statement: if z0 == 0 goto i11 = 1 
(assert (= (ite var3655 1 0) 0)) ; Cond: z0 == 0 
(define-const var1539 Int 1) ; Statement: i11 = 1 
(assert true) ; Non Conditional
(assert true)
(define-const var1950 Int (length/-134980193 var3816)) ; Statement: $i12 = virtualinvoke r1.<java.lang.String: int length()>() 
(define-const var2386 Int (- var1950 1)) ; Statement: $i13 = $i12 - 1 
 ; Statement: if i11 >= $i13 goto (branch) 
(assert (>= var1539 var2386)) ; Cond: i11 >= $i13 
 ; Statement: if z0 == 0 goto $r2 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= (ite var3655 1 0) 0)) ; Cond: z0 == 0 
(assert true)
(define-const var3030 String (toString/-2075883882 var230!1)) ; Statement: $r2 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r2 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), length/-134980193=([java.lang.String], int), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3147=org.antlr.v4.codegen.Target, var1846=r3, var1185=org.antlr.v4.codegen.CodeGenerator, var672=r5, var3816=r1, var3985=null_type, var3655=z0, var970=z2, var230=$r6, var1539=i11, var1950=$i12, var2386=$i13, var3030=$r2}
; {org.antlr.v4.codegen.Target=var3147, r3=var1846, org.antlr.v4.codegen.CodeGenerator=var1185, r5=var672, r1=var3816, null_type=var3985, z0=var3655, z2=var970, $r6=var230, i11=var1539, $i12=var1950, $i13=var2386, $r2=var3030}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.String: int length()>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.String: int length()>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r3 := @this: org.antlr.v4.codegen.Target;	r5 := @parameter0: org.antlr.v4.codegen.CodeGenerator;	r1 := @parameter1: java.lang.String;	z0 := @parameter2: boolean;	z2 := @parameter3: boolean;	$r6 = new java.lang.StringBuilder;	specialinvoke $r6.<java.lang.StringBuilder: void <init>()>();	if z0 == 0 goto i11 = 1;	i11 = 1;	$i12 = virtualinvoke r1.<java.lang.String: int length()>();	$i13 = $i12 - 1;	if i11 >= $i13 goto (branch);	if z0 == 0 goto $r2 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	$r2 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	return $r2
;block_num 5