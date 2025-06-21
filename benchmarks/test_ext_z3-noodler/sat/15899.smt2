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

(declare-sort var2001 0)
(declare-sort var2806 0)
(declare-sort var3245 0)
(declare-sort var2663 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-840298471 (var3245) void)
(declare-fun cast-from-var2001-to-var3245 (var2001) var3245)
(declare-fun var2663-init () var2663)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var2663 String) void)
(declare-const null-var2001 var2001)
(declare-const null-Int Int)
(declare-const null-var2806 var2806)
(declare-const var1621 var2001) ; Statement: r0 := @this: org.apache.dubbo.remoting.buffer.DynamicChannelBuffer 
(assert (not (= var1621 null-var2001)))
(declare-const var2000 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var2000 null-Int)))
(declare-const var1780 var2806) ; Statement: r1 := @parameter1: org.apache.dubbo.remoting.buffer.ChannelBufferFactory 
(assert (not (= var1780 null-var2806)))
(assert true)
;(assert (<init>/-840298471 (cast-from-var2001-to-var3245 var1621))) ; Statement: specialinvoke r0.<org.apache.dubbo.remoting.buffer.AbstractChannelBuffer: void <init>()>() 

(declare-const var1621!1 var2001)
 ; Statement: if i0 >= 0 goto (branch) 
(assert (not (>= var2000 0))) ; Negate: Cond: i0 >= 0  
(define-const var573 var2663 var2663-init) ; Statement: $r4 = new java.lang.IllegalArgumentException 
(define-const var1179 String String-init) ; Statement: $r5 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1179)) ; Statement: specialinvoke $r5.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1179!1 String)
(assert (= var1179!1 ""))
(assert true)
(define-const var111 String (append/672562846 var1179!1 "estimatedLength: ")) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("estimatedLength: ") 
(declare-const var1179!2 String)
(assert (= var1179!2 (str.++ var1179!1 "estimatedLength: ")))
(assert true)
(define-const var1448 String (append/-1001720160 var111 var2000)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var111!1 String)
(assert (str.prefixof var111 var111!1))
(assert true)
(define-const var302 String (toString/-2075883882 var1448)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var573 var302)) ; Statement: specialinvoke $r4.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r8) 

(declare-const var573!1 var2663)
(declare-const var302!1 String)
 ; Statement: throw $r4 
(check-sat)
; {<init>/-840298471=([org.apache.dubbo.remoting.buffer.AbstractChannelBuffer], void), cast-from-var2001-to-var3245=([org.apache.dubbo.remoting.buffer.DynamicChannelBuffer], org.apache.dubbo.remoting.buffer.AbstractChannelBuffer), var2663-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var2001=org.apache.dubbo.remoting.buffer.DynamicChannelBuffer, var1621=r0, var2000=i0, var2806=org.apache.dubbo.remoting.buffer.ChannelBufferFactory, var1780=r1, var3245=org.apache.dubbo.remoting.buffer.AbstractChannelBuffer, var2663=java.lang.IllegalArgumentException, var573=$r4, var1179=$r5, var111=$r6, var1448=$r7, var302=$r8}
; {org.apache.dubbo.remoting.buffer.DynamicChannelBuffer=var2001, r0=var1621, i0=var2000, org.apache.dubbo.remoting.buffer.ChannelBufferFactory=var2806, r1=var1780, org.apache.dubbo.remoting.buffer.AbstractChannelBuffer=var3245, java.lang.IllegalArgumentException=var2663, $r4=var573, $r5=var1179, $r6=var111, $r7=var1448, $r8=var302}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.buffer.DynamicChannelBuffer;	i0 := @parameter0: int;	r1 := @parameter1: org.apache.dubbo.remoting.buffer.ChannelBufferFactory;	specialinvoke r0.<org.apache.dubbo.remoting.buffer.AbstractChannelBuffer: void <init>()>();	if i0 >= 0 goto (branch);	$r4 = new java.lang.IllegalArgumentException;	$r5 = new java.lang.StringBuilder;	specialinvoke $r5.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("estimatedLength: ");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r4.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r8);	throw $r4
;block_num 2