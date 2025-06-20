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

(declare-sort var3885 0)
(declare-sort var3784 0)
(declare-sort var3965 0)
(declare-sort var81 0)
(declare-sort var2210 0)
(declare-sort var2884 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var81-init () var81)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var2210_toString/-109309168 (var2884) String)
(declare-fun cast-from-var3965-to-var2884 (var3965) var2884)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1557872005 (var81 String) void)
(declare-const null-var3885 var3885)
(declare-const null-var3784 var3784)
(declare-const null-var3965 var3965)
(declare-const var1452 var3885) ; Statement: r9 := @this: org.apache.dubbo.remoting.transport.codec.TransportCodec 
(assert (not (= var1452 null-var3885)))
(declare-const var2612 var3784) ; Statement: r0 := @parameter0: org.apache.dubbo.common.serialize.ObjectInput 
(assert (not (= var2612 null-var3784)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2662 var3965) ; Statement: $r2 := @caughtexception 
(assert (not (= var2662 null-var3965)))
(define-const var1707 var81 var81-init) ; Statement: $r3 = new java.io.IOException 
(define-const var2191 String String-init) ; Statement: $r4 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2191)) ; Statement: specialinvoke $r4.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2191!1 String)
(assert (= var2191!1 ""))
(assert true)
(define-const var3987 String (append/672562846 var2191!1 "ClassNotFoundException: ")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ClassNotFoundException: ") 
(declare-const var2191!2 String)
(assert (= var2191!2 (str.++ var2191!1 "ClassNotFoundException: ")))
(define-const var2358 String (var2210_toString/-109309168 (cast-from-var3965-to-var2884 var2662))) ; Statement: $r5 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String toString(java.lang.Throwable)>($r2) 
(assert true)
(define-const var1679 String (append/672562846 var3987 var2358)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var3987!1 String)
(assert (= var3987!1 (str.++ var3987 var2358)))
(assert true)
(define-const var3829 String (toString/-2075883882 var1679)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1557872005 var1707 var3829)) ; Statement: specialinvoke $r3.<java.io.IOException: void <init>(java.lang.String)>($r8) 

(declare-const var1707!1 var81)
(declare-const var3829!1 String)
 ; Statement: throw $r3 
(check-sat)
; {var81-init=([], java.io.IOException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var2210_toString/-109309168=([java.lang.Throwable], java.lang.String), cast-from-var3965-to-var2884=([java.lang.ClassNotFoundException], java.lang.Throwable), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1557872005=([java.io.IOException, java.lang.String], void)}
; {var3885=org.apache.dubbo.remoting.transport.codec.TransportCodec, var1452=r9, var3784=org.apache.dubbo.common.serialize.ObjectInput, var2612=r0, var3965=java.lang.ClassNotFoundException, var2662=$r2, var81=java.io.IOException, var1707=$r3, var2191=$r4, var3987=$r6, var2210=org.apache.dubbo.common.utils.StringUtils, var2884=java.lang.Throwable, var2358=$r5, var1679=$r7, var3829=$r8}
; {org.apache.dubbo.remoting.transport.codec.TransportCodec=var3885, r9=var1452, org.apache.dubbo.common.serialize.ObjectInput=var3784, r0=var2612, java.lang.ClassNotFoundException=var3965, $r2=var2662, java.io.IOException=var81, $r3=var1707, $r4=var2191, $r6=var3987, org.apache.dubbo.common.utils.StringUtils=var2210, java.lang.Throwable=var2884, $r5=var2358, $r7=var1679, $r8=var3829}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: java.lang.String toString(java.lang.Throwable)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<org.apache.dubbo.common.utils.StringUtils: java.lang.String toString(java.lang.Throwable)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r9 := @this: org.apache.dubbo.remoting.transport.codec.TransportCodec;	r0 := @parameter0: org.apache.dubbo.common.serialize.ObjectInput;	$r2 := @caughtexception;	$r3 = new java.io.IOException;	$r4 = new java.lang.StringBuilder;	specialinvoke $r4.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ClassNotFoundException: ");	$r5 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String toString(java.lang.Throwable)>($r2);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r3.<java.io.IOException: void <init>(java.lang.String)>($r8);	throw $r3
;block_num 2