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

(declare-sort var725 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/-1061048412 ((s String)) String s)
(declare-fun getParameterTypes/938597008 (var725) (Array Int ClassObject))
(declare-fun getLength-Arr-ClassObject-1 ((Array Int ClassObject)) Int)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var725 var725)
(declare-const var2793 var725) ; Statement: r1 := @parameter0: java.lang.reflect.Constructor 
(assert (not (= var2793 null-var725)))
(define-const var3381 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/-1061048412 var3381 "(")) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>("(") 
(declare-const var3381!1 String)
(assert (= var3381!1 "("))
(assert true)
(define-const var337 (Array Int ClassObject) (getParameterTypes/938597008 var2793)) ; Statement: r2 = virtualinvoke r1.<java.lang.reflect.Constructor: java.lang.Class[] getParameterTypes()>() 
(define-const var2228 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
(define-const var2726 Int (getLength-Arr-ClassObject-1 var337)) ; Statement: $i0 = lengthof r2 
 ; Statement: if i1 >= $i0 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41) 
(assert (>= var2228 var2726)) ; Cond: i1 >= $i0 
(assert true)
;(assert (append/-1166366385 var3381!1 41)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41) 
(declare-const var3381!2 String)
(assert (str.prefixof var3381!1 var3381!2))
(assert true)
(define-const var2809 String (toString/-2075883882 var3381!2)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r3 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/-1061048412=([java.lang.StringBuilder, java.lang.String], void), getParameterTypes/938597008=([java.lang.reflect.Constructor], java.lang.Class[]), getLength-Arr-ClassObject-1=([java.lang.Class[]], int), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var725=java.lang.reflect.Constructor, var2793=r1, var3381=$r0, var337=r2, var2228=i1, var2726=$i0, var2809=$r3}
; {java.lang.reflect.Constructor=var725, r1=var2793, $r0=var3381, r2=var337, i1=var2228, $i0=var2726, $r3=var2809}
;seq <java.lang.StringBuilder: void <init>(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @parameter0: java.lang.reflect.Constructor;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>("(");	r2 = virtualinvoke r1.<java.lang.reflect.Constructor: java.lang.Class[] getParameterTypes()>();	i1 = 0;	$i0 = lengthof r2;	if i1 >= $i0 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41);	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r3
;block_num 3