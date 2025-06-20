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

(declare-sort var257 0)
(declare-sort var1486 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getAddress/1707481140 (var257) var1486)
(declare-fun getHostAddress/1493983505 (var1486) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getPort/-1397617271 (var257) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var257 var257)
(declare-const var658 var257) ; Statement: r1 := @parameter0: java.net.InetSocketAddress 
(assert (not (= var658 null-var257)))
(define-const var2021 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2021)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2021!1 String)
(assert (= var2021!1 ""))
(assert true)
(define-const var566 var1486 (getAddress/1707481140 var658)) ; Statement: $r2 = virtualinvoke r1.<java.net.InetSocketAddress: java.net.InetAddress getAddress()>() 
(assert true)
(define-const var1805 String (getHostAddress/1493983505 var566)) ; Statement: $r3 = virtualinvoke $r2.<java.net.InetAddress: java.lang.String getHostAddress()>() 
(assert true)
(define-const var2566 String (append/672562846 var2021!1 var1805)) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var2021!2 String)
(assert (= var2021!2 (str.++ var2021!1 var1805)))
(assert true)
(define-const var357 String (append/672562846 var2566 ":")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(":") 
(declare-const var2566!1 String)
(assert (= var2566!1 (str.++ var2566 ":")))
(assert true)
(define-const var2525 Int (getPort/-1397617271 var658)) ; Statement: $i0 = virtualinvoke r1.<java.net.InetSocketAddress: int getPort()>() 
(assert true)
(define-const var3162 String (append/-1001720160 var357 var2525)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var357!1 String)
(assert (str.prefixof var357 var357!1))
(assert true)
(define-const var1346 String (toString/-2075883882 var3162)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r7 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getAddress/1707481140=([java.net.InetSocketAddress], java.net.InetAddress), getHostAddress/1493983505=([java.net.InetAddress], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getPort/-1397617271=([java.net.InetSocketAddress], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var257=java.net.InetSocketAddress, var658=r1, var2021=$r0, var1486=java.net.InetAddress, var566=$r2, var1805=$r3, var2566=$r4, var357=$r5, var2525=$i0, var3162=$r6, var1346=$r7}
; {java.net.InetSocketAddress=var257, r1=var658, $r0=var2021, java.net.InetAddress=var1486, $r2=var566, $r3=var1805, $r4=var2566, $r5=var357, $i0=var2525, $r6=var3162, $r7=var1346}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @parameter0: java.net.InetSocketAddress;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke r1.<java.net.InetSocketAddress: java.net.InetAddress getAddress()>();	$r3 = virtualinvoke $r2.<java.net.InetAddress: java.lang.String getHostAddress()>();	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(":");	$i0 = virtualinvoke r1.<java.net.InetSocketAddress: int getPort()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	return $r7
;block_num 1