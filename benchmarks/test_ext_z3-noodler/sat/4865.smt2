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

(declare-sort var137 0)
(declare-sort var305 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var305-init () var305)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1425936906 (var305 String var137) void)
(declare-const null-ClassObject ClassObject)
(declare-const null-Int Int)
(declare-const null-var137 var137)
(declare-const var2768 ClassObject) ; Statement: r0 := @parameter0: java.lang.Class 
(assert (not (= var2768 null-ClassObject)))
(declare-const var2815 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var2815 null-Int)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2519 var137) ; Statement: $r15 := @caughtexception 
(assert (not (= var2519 null-var137)))
(define-const var1043 var305 var305-init) ; Statement: $r16 = new java.lang.IllegalArgumentException 
(define-const var2731 String String-init) ; Statement: $r17 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2731)) ; Statement: specialinvoke $r17.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2731!1 String)
(assert (= var2731!1 ""))
(assert true)
(define-const var2824 String (getName/-1958580599 var2768)) ; Statement: $r18 = virtualinvoke r0.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var162 String (append/672562846 var2731!1 var2824)) ; Statement: $r19 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r18) 
(declare-const var2731!2 String)
(assert (= var2731!2 (str.++ var2731!1 var2824)))
(assert true)
(define-const var150 String (append/672562846 var162 " generic type undefined!")) ; Statement: $r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" generic type undefined!") 
(declare-const var162!1 String)
(assert (= var162!1 (str.++ var162 " generic type undefined!")))
(assert true)
(define-const var3622 String (toString/-2075883882 var150)) ; Statement: $r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1425936906 var1043 var3622 var2519)) ; Statement: specialinvoke $r16.<java.lang.IllegalArgumentException: void <init>(java.lang.String,java.lang.Throwable)>($r21, $r15) 

(declare-const var1043!1 var305)
(declare-const var3622!1 String)
(declare-const var2519!1 var137)
 ; Statement: throw $r16 
(check-sat)
; {var305-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getName/-1958580599=([java.lang.Class], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1425936906=([java.lang.IllegalArgumentException, java.lang.String, java.lang.Throwable], void)}
; {var2768=r0, var2815=i0, var137=java.lang.Throwable, var2519=$r15, var305=java.lang.IllegalArgumentException, var1043=$r16, var2731=$r17, var2824=$r18, var162=$r19, var150=$r20, var3622=$r21}
; {r0=var2768, i0=var2815, java.lang.Throwable=var137, $r15=var2519, java.lang.IllegalArgumentException=var305, $r16=var1043, $r17=var2731, $r18=var2824, $r19=var162, $r20=var150, $r21=var3622}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.Class;	i0 := @parameter1: int;	$r15 := @caughtexception;	$r16 = new java.lang.IllegalArgumentException;	$r17 = new java.lang.StringBuilder;	specialinvoke $r17.<java.lang.StringBuilder: void <init>()>();	$r18 = virtualinvoke r0.<java.lang.Class: java.lang.String getName()>();	$r19 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r18);	$r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" generic type undefined!");	$r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r16.<java.lang.IllegalArgumentException: void <init>(java.lang.String,java.lang.Throwable)>($r21, $r15);	throw $r16
;block_num 2