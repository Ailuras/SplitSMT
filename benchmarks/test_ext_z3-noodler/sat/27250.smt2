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

(declare-sort var1215 0)
(declare-sort var330 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var1215!class ClassObject)
(declare-fun isInterface/-352192428 (ClassObject) Bool)
(declare-fun isAssignableFrom/-1028998700 (ClassObject ClassObject) Bool)
(declare-fun var330-init () var330)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var330 String) void)
(declare-const null-ClassObject ClassObject)
(declare-const var2288 ClassObject) ; Statement: r0 := @parameter0: java.lang.Class 
(assert (not (= var2288 null-ClassObject)))
(assert true)
(define-const var3342 Bool (isInterface/-352192428 var2288)) ; Statement: $z0 = virtualinvoke r0.<java.lang.Class: boolean isInterface()>() 
 ; Statement: if $z0 == 0 goto $r1 = class "Ljava/util/Map;" 
(assert (= (ite var3342 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3046 ClassObject var1215!class) ; Statement: $r1 = class "Ljava/util/Map;" 
(assert true)
(define-const var426 Bool (isAssignableFrom/-1028998700 var3046 var2288)) ; Statement: $z1 = virtualinvoke $r1.<java.lang.Class: boolean isAssignableFrom(java.lang.Class)>(r0) 
 ; Statement: if $z1 == 0 goto $r24 = new java.lang.IllegalArgumentException 
(assert (= (ite var426 1 0) 0)) ; Cond: $z1 == 0 
(define-const var2369 var330 var330-init) ; Statement: $r24 = new java.lang.IllegalArgumentException 
(define-const var2991 String String-init) ; Statement: $r25 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2991)) ; Statement: specialinvoke $r25.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2991!1 String)
(assert (= var2991!1 ""))
(assert true)
(define-const var1776 String (append/672562846 var2991!1 "Unsupported map type: ")) ; Statement: $r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Unsupported map type: ") 
(declare-const var2991!2 String)
(assert (= var2991!2 (str.++ var2991!1 "Unsupported map type: ")))
(assert true)
(define-const var2654 String (getName/-1958580599 var2288)) ; Statement: $r27 = virtualinvoke r0.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var696 String (append/672562846 var1776 var2654)) ; Statement: $r28 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r27) 
(declare-const var1776!1 String)
(assert (= var1776!1 (str.++ var1776 var2654)))
(assert true)
(define-const var2635 String (toString/-2075883882 var696)) ; Statement: $r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var2369 var2635)) ; Statement: specialinvoke $r24.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r29) 

(declare-const var2369!1 var330)
(declare-const var2635!1 String)
 ; Statement: throw $r24 
(check-sat)
; {isInterface/-352192428=([java.lang.Class], boolean), isAssignableFrom/-1028998700=([java.lang.Class, java.lang.Class], boolean), var330-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getName/-1958580599=([java.lang.Class], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var2288=r0, var3342=$z0, var1215=java.util.Map, var3046=$r1, var426=$z1, var330=java.lang.IllegalArgumentException, var2369=$r24, var2991=$r25, var1776=$r26, var2654=$r27, var696=$r28, var2635=$r29}
; {r0=var2288, $z0=var3342, java.util.Map=var1215, $r1=var3046, $z1=var426, java.lang.IllegalArgumentException=var330, $r24=var2369, $r25=var2991, $r26=var1776, $r27=var2654, $r28=var696, $r29=var2635}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.Class;	$z0 = virtualinvoke r0.<java.lang.Class: boolean isInterface()>();	if $z0 == 0 goto $r1 = class "Ljava/util/Map;";	$r1 = class "Ljava/util/Map;";	$z1 = virtualinvoke $r1.<java.lang.Class: boolean isAssignableFrom(java.lang.Class)>(r0);	if $z1 == 0 goto $r24 = new java.lang.IllegalArgumentException;	$r24 = new java.lang.IllegalArgumentException;	$r25 = new java.lang.StringBuilder;	specialinvoke $r25.<java.lang.StringBuilder: void <init>()>();	$r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Unsupported map type: ");	$r27 = virtualinvoke r0.<java.lang.Class: java.lang.String getName()>();	$r28 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r27);	$r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r24.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r29);	throw $r24
;block_num 3