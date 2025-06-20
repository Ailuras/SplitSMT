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

(declare-sort var2931 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/-1061048412 ((s String)) String s)
(declare-fun getParameterTypes/938597008 (var2931) (Array Int ClassObject))
(declare-fun getLength-Arr-ClassObject-1 ((Array Int ClassObject)) Int)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2931 var2931)
(declare-const var3391 var2931) ; Statement: r1 := @parameter0: java.lang.reflect.Constructor 
(assert (not (= var3391 null-var2931)))
(define-const var3593 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/-1061048412 var3593 "(")) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>("(") 
(declare-const var3593!1 String)
(assert (= var3593!1 "("))
(assert true)
(define-const var3644 (Array Int ClassObject) (getParameterTypes/938597008 var3391)) ; Statement: r2 = virtualinvoke r1.<java.lang.reflect.Constructor: java.lang.Class[] getParameterTypes()>() 
(define-const var3265 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
(define-const var179 Int (getLength-Arr-ClassObject-1 var3644)) ; Statement: $i0 = lengthof r2 
 ; Statement: if i1 >= $i0 goto $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41) 
(assert (>= var3265 var179)) ; Cond: i1 >= $i0 
(assert true)
(define-const var3423 String (append/-1166366385 var3593!1 41)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41) 
(declare-const var3593!2 String)
(assert (str.prefixof var3593!1 var3593!2))
(assert true)
;(assert (append/-1166366385 var3423 86)) ; Statement: virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(86) 
(declare-const var3423!1 String)
(assert (str.prefixof var3423 var3423!1))
(assert true)
(define-const var765 String (toString/-2075883882 var3593!2)) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r4 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/-1061048412=([java.lang.StringBuilder, java.lang.String], void), getParameterTypes/938597008=([java.lang.reflect.Constructor], java.lang.Class[]), getLength-Arr-ClassObject-1=([java.lang.Class[]], int), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2931=java.lang.reflect.Constructor, var3391=r1, var3593=$r0, var3644=r2, var3265=i1, var179=$i0, var3423=$r3, var765=$r4}
; {java.lang.reflect.Constructor=var2931, r1=var3391, $r0=var3593, r2=var3644, i1=var3265, $i0=var179, $r3=var3423, $r4=var765}
;seq <java.lang.StringBuilder: void <init>(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @parameter0: java.lang.reflect.Constructor;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>("(");	r2 = virtualinvoke r1.<java.lang.reflect.Constructor: java.lang.Class[] getParameterTypes()>();	i1 = 0;	$i0 = lengthof r2;	if i1 >= $i0 goto $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41);	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41);	virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(86);	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r4
;block_num 3