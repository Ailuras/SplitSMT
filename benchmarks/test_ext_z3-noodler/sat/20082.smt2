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

(declare-sort var3732 0)
(declare-sort var347 0)
(declare-sort var1087 0)
(declare-sort var3431 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var1087_identityHashCode/1096208673 (var3431) Int)
(declare-fun cast-from-var3732-to-var3431 (var3732) var3431)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3732 var3732)
(declare-const null-String String)
(declare-const var2734 var3732) ; Statement: r1 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var2734 null-var3732)))
(declare-const var2864 String) ; Statement: r4 := @parameter1: java.lang.String 
(assert (not (= var2864 null-String)))
(define-const var3832 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3832)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3832!1 String)
(assert (= var3832!1 ""))
(assert true)
(define-const var3771 String (append/672562846 var3832!1 "callback.service.proxy.")) ; Statement: $r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("callback.service.proxy.") 
(declare-const var3832!2 String)
(assert (= var3832!2 (str.++ var3832!1 "callback.service.proxy.")))
(define-const var3680 Int (var1087_identityHashCode/1096208673 (cast-from-var3732-to-var3431 var2734))) ; Statement: $i0 = staticinvoke <java.lang.System: int identityHashCode(java.lang.Object)>(r1) 
(assert true)
(define-const var3576 String (append/-1001720160 var3771 var3680)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var3771!1 String)
(assert (str.prefixof var3771 var3771!1))
(assert true)
(define-const var826 String (append/672562846 var3576 ".")) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".") 
(declare-const var3576!1 String)
(assert (= var3576!1 (str.++ var3576 ".")))
(assert true)
(define-const var2158 String (append/672562846 var826 var2864)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4) 
(declare-const var826!1 String)
(assert (= var826!1 (str.++ var826 var2864)))
(assert true)
(define-const var955 String (append/672562846 var2158 ".COUNT")) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".COUNT") 
(declare-const var2158!1 String)
(assert (= var2158!1 (str.++ var2158 ".COUNT")))
(assert true)
(define-const var1801 String (toString/-2075883882 var955)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r8 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var1087_identityHashCode/1096208673=([java.lang.Object], int), cast-from-var3732-to-var3431=([org.apache.dubbo.remoting.Channel], java.lang.Object), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3732=org.apache.dubbo.remoting.Channel, var2734=r1, var2864=r4, var347=null_type, var3832=$r0, var3771=$r2, var1087=java.lang.System, var3431=java.lang.Object, var3680=$i0, var3576=$r3, var826=$r5, var2158=$r6, var955=$r7, var1801=$r8}
; {org.apache.dubbo.remoting.Channel=var3732, r1=var2734, r4=var2864, null_type=var347, $r0=var3832, $r2=var3771, java.lang.System=var1087, java.lang.Object=var3431, $i0=var3680, $r3=var3576, $r5=var826, $r6=var2158, $r7=var955, $r8=var1801}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @parameter0: org.apache.dubbo.remoting.Channel;	r4 := @parameter1: java.lang.String;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("callback.service.proxy.");	$i0 = staticinvoke <java.lang.System: int identityHashCode(java.lang.Object)>(r1);	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".COUNT");	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	return $r8
;block_num 1