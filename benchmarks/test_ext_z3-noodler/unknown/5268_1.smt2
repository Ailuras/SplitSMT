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

(declare-sort var479 0)
(declare-sort var3764 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/-1061048412 ((s String)) String s)
(declare-fun getParameterTypes/1922901921 (var479) (Array Int var3764))
(declare-fun getLength-Arr-var3764-1 ((Array Int var3764)) Int)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var479 var479)
(declare-const var828 var479) ; Statement: r1 := @parameter0: javassist.CtConstructor 
(assert (not (= var828 null-var479)))
(define-const var2782 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/-1061048412 var2782 "(")) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>("(") 
(declare-const var2782!1 String)
(assert (= var2782!1 "("))
(assert true)
(define-const var391 (Array Int var3764) (getParameterTypes/1922901921 var828)) ; Statement: r2 = virtualinvoke r1.<javassist.CtConstructor: javassist.CtClass[] getParameterTypes()>() 
(define-const var2919 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
(define-const var1053 Int (getLength-Arr-var3764-1 var391)) ; Statement: $i0 = lengthof r2 
 ; Statement: if i1 >= $i0 goto $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41) 
(assert (>= var2919 var1053)) ; Cond: i1 >= $i0 
(assert true)
(define-const var1768 String (append/-1166366385 var2782!1 41)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41) 
(declare-const var2782!2 String)
(assert (str.prefixof var2782!1 var2782!2))
(assert true)
;(assert (append/-1166366385 var1768 86)) ; Statement: virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(86) 
(declare-const var1768!1 String)
(assert (str.prefixof var1768 var1768!1))
(assert true)
(define-const var1556 String (toString/-2075883882 var2782!2)) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r4 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/-1061048412=([java.lang.StringBuilder, java.lang.String], void), getParameterTypes/1922901921=([javassist.CtConstructor], javassist.CtClass[]), getLength-Arr-var3764-1=([javassist.CtClass[]], int), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var479=javassist.CtConstructor, var828=r1, var2782=$r0, var3764=javassist.CtClass, var391=r2, var2919=i1, var1053=$i0, var1768=$r3, var1556=$r4}
; {javassist.CtConstructor=var479, r1=var828, $r0=var2782, javassist.CtClass=var3764, r2=var391, i1=var2919, $i0=var1053, $r3=var1768, $r4=var1556}
;seq <java.lang.StringBuilder: void <init>(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @parameter0: javassist.CtConstructor;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>("(");	r2 = virtualinvoke r1.<javassist.CtConstructor: javassist.CtClass[] getParameterTypes()>();	i1 = 0;	$i0 = lengthof r2;	if i1 >= $i0 goto $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41);	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41);	virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(86);	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r4
;block_num 3