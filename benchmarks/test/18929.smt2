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

(declare-sort var575 0)
(declare-sort var1432 0)
(declare-sort var2171 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getClass/1258963082 (var1432) ClassObject)
(declare-fun cast-from-var575-to-var1432 (var575) var1432)
(declare-fun getSimpleName/-390194377 (ClassObject) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun headers/-578554792 (var575) var2171)
(declare-fun append/-1031950772 (String var1432) String)
(declare-fun cast-from-var2171-to-var1432 (var2171) var1432)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var575 var575)
(declare-const var2006 var575) ; Statement: r1 := @this: org.apache.dubbo.remoting.http12.netty4.NettyHttpHeaders 
(assert (not (= var2006 null-var575)))
(define-const var2479 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2479)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2479!1 String)
(assert (= var2479!1 ""))
(assert true)
(define-const var1677 ClassObject (getClass/1258963082 (cast-from-var575-to-var1432 var2006))) ; Statement: $r2 = virtualinvoke r1.<java.lang.Object: java.lang.Class getClass()>() 
(assert true)
(define-const var2129 String (getSimpleName/-390194377 var1677)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.Class: java.lang.String getSimpleName()>() 
(assert true)
(define-const var2397 String (append/672562846 var2479!1 var2129)) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var2479!2 String)
(assert (= var2479!2 (str.++ var2479!1 var2129)))
(assert true)
(define-const var786 String (append/672562846 var2397 "{headers=")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("{headers=") 
(declare-const var2397!1 String)
(assert (= var2397!1 (str.++ var2397 "{headers=")))
(define-const var3816 var2171 (headers/-578554792 var2006)) ; Statement: $r5 = r1.<org.apache.dubbo.remoting.http12.netty4.NettyHttpHeaders: io.netty.handler.codec.Headers headers> 
(assert true)
(define-const var2203 String (append/-1031950772 var786 (cast-from-var2171-to-var1432 var3816))) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5) 
(declare-const var786!1 String)
(assert (str.prefixof var786 var786!1))
(assert true)
(define-const var953 String (append/-1166366385 var2203 125)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var2203!1 String)
(assert (str.prefixof var2203 var2203!1))
(assert true)
(define-const var1453 String (toString/-2075883882 var953)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r9 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-var575-to-var1432=([org.apache.dubbo.remoting.http12.netty4.NettyHttpHeaders], java.lang.Object), getSimpleName/-390194377=([java.lang.Class], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), headers/-578554792=([org.apache.dubbo.remoting.http12.netty4.NettyHttpHeaders], io.netty.handler.codec.Headers), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var2171-to-var1432=([io.netty.handler.codec.Headers], java.lang.Object), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var575=org.apache.dubbo.remoting.http12.netty4.NettyHttpHeaders, var2006=r1, var2479=$r0, var1432=java.lang.Object, var1677=$r2, var2129=$r3, var2397=$r4, var786=$r6, var2171=io.netty.handler.codec.Headers, var3816=$r5, var2203=$r7, var953=$r8, var1453=$r9}
; {org.apache.dubbo.remoting.http12.netty4.NettyHttpHeaders=var575, r1=var2006, $r0=var2479, java.lang.Object=var1432, $r2=var1677, $r3=var2129, $r4=var2397, $r6=var786, io.netty.handler.codec.Headers=var2171, $r5=var3816, $r7=var2203, $r8=var953, $r9=var1453}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.remoting.http12.netty4.NettyHttpHeaders;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke r1.<java.lang.Object: java.lang.Class getClass()>();	$r3 = virtualinvoke $r2.<java.lang.Class: java.lang.String getSimpleName()>();	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("{headers=");	$r5 = r1.<org.apache.dubbo.remoting.http12.netty4.NettyHttpHeaders: io.netty.handler.codec.Headers headers>;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	return $r9
;block_num 1