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

(declare-sort var2011 0)
(declare-sort var1801 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var2011!class ClassObject)
(declare-fun isInterface/-352192428 (ClassObject) Bool)
(declare-fun isAssignableFrom/-1028998700 (ClassObject ClassObject) Bool)
(declare-fun var1801-init () var1801)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var1801 String) void)
(declare-const null-ClassObject ClassObject)
(declare-const var467 ClassObject) ; Statement: r0 := @parameter0: java.lang.Class 
(assert (not (= var467 null-ClassObject)))
(assert true)
(define-const var3192 Bool (isInterface/-352192428 var467)) ; Statement: $z0 = virtualinvoke r0.<java.lang.Class: boolean isInterface()>() 
 ; Statement: if $z0 == 0 goto $r1 = class "Ljava/util/Collection;" 
(assert (= (ite var3192 1 0) 0)) ; Cond: $z0 == 0 
(define-const var870 ClassObject var2011!class) ; Statement: $r1 = class "Ljava/util/Collection;" 
(assert true)
(define-const var2689 Bool (isAssignableFrom/-1028998700 var870 var467)) ; Statement: $z1 = virtualinvoke $r1.<java.lang.Class: boolean isAssignableFrom(java.lang.Class)>(r0) 
 ; Statement: if $z1 == 0 goto $r24 = new java.lang.IllegalArgumentException 
(assert (= (ite var2689 1 0) 0)) ; Cond: $z1 == 0 
(define-const var3598 var1801 var1801-init) ; Statement: $r24 = new java.lang.IllegalArgumentException 
(define-const var3022 String String-init) ; Statement: $r25 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3022)) ; Statement: specialinvoke $r25.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3022!1 String)
(assert (= var3022!1 ""))
(assert true)
(define-const var1138 String (append/672562846 var3022!1 "Unsupported collection type: ")) ; Statement: $r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Unsupported collection type: ") 
(declare-const var3022!2 String)
(assert (= var3022!2 (str.++ var3022!1 "Unsupported collection type: ")))
(assert true)
(define-const var2273 String (getName/-1958580599 var467)) ; Statement: $r27 = virtualinvoke r0.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var1242 String (append/672562846 var1138 var2273)) ; Statement: $r28 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r27) 
(declare-const var1138!1 String)
(assert (= var1138!1 (str.++ var1138 var2273)))
(assert true)
(define-const var3705 String (toString/-2075883882 var1242)) ; Statement: $r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var3598 var3705)) ; Statement: specialinvoke $r24.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r29) 

(declare-const var3598!1 var1801)
(declare-const var3705!1 String)
 ; Statement: throw $r24 
(check-sat)
; {isInterface/-352192428=([java.lang.Class], boolean), isAssignableFrom/-1028998700=([java.lang.Class, java.lang.Class], boolean), var1801-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getName/-1958580599=([java.lang.Class], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var467=r0, var3192=$z0, var2011=java.util.Collection, var870=$r1, var2689=$z1, var1801=java.lang.IllegalArgumentException, var3598=$r24, var3022=$r25, var1138=$r26, var2273=$r27, var1242=$r28, var3705=$r29}
; {r0=var467, $z0=var3192, java.util.Collection=var2011, $r1=var870, $z1=var2689, java.lang.IllegalArgumentException=var1801, $r24=var3598, $r25=var3022, $r26=var1138, $r27=var2273, $r28=var1242, $r29=var3705}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.Class;	$z0 = virtualinvoke r0.<java.lang.Class: boolean isInterface()>();	if $z0 == 0 goto $r1 = class "Ljava/util/Collection;";	$r1 = class "Ljava/util/Collection;";	$z1 = virtualinvoke $r1.<java.lang.Class: boolean isAssignableFrom(java.lang.Class)>(r0);	if $z1 == 0 goto $r24 = new java.lang.IllegalArgumentException;	$r24 = new java.lang.IllegalArgumentException;	$r25 = new java.lang.StringBuilder;	specialinvoke $r25.<java.lang.StringBuilder: void <init>()>();	$r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Unsupported collection type: ");	$r27 = virtualinvoke r0.<java.lang.Class: java.lang.String getName()>();	$r28 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r27);	$r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r24.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r29);	throw $r24
;block_num 3