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

(declare-sort var3375 0)
(declare-sort var2319 0)
(declare-sort var591 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getClass/1258963082 (var2319) ClassObject)
(declare-fun cast-from-var3375-to-var2319 (var3375) var2319)
(declare-fun getSimpleName/-390194377 (ClassObject) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1166366385 (String Int) String)
(declare-fun readerIndex/-1127548904 (var3375) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun writerIndex/-1127548904 (var3375) Int)
(declare-fun capacity/1290500406 (var591) Int)
(declare-fun cast-from-var3375-to-var591 (var3375) var591)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3375 var3375)
(declare-const var2965 var3375) ; Statement: r1 := @this: org.apache.dubbo.remoting.buffer.AbstractChannelBuffer 
(assert (not (= var2965 null-var3375)))
(define-const var2721 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2721)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2721!1 String)
(assert (= var2721!1 ""))
(assert true)
(define-const var812 ClassObject (getClass/1258963082 (cast-from-var3375-to-var2319 var2965))) ; Statement: $r2 = virtualinvoke r1.<java.lang.Object: java.lang.Class getClass()>() 
(assert true)
(define-const var3379 String (getSimpleName/-390194377 var812)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.Class: java.lang.String getSimpleName()>() 
(assert true)
(define-const var2906 String (append/672562846 var2721!1 var3379)) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var2721!2 String)
(assert (= var2721!2 (str.++ var2721!1 var3379)))
(assert true)
(define-const var512 String (append/-1166366385 var2906 40)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40) 
(declare-const var2906!1 String)
(assert (str.prefixof var2906 var2906!1))
(assert true)
(define-const var504 String (append/672562846 var512 "ridx=")) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ridx=") 
(declare-const var512!1 String)
(assert (= var512!1 (str.++ var512 "ridx=")))
(define-const var1213 Int (readerIndex/-1127548904 var2965)) ; Statement: $i0 = r1.<org.apache.dubbo.remoting.buffer.AbstractChannelBuffer: int readerIndex> 
(assert true)
(define-const var3102 String (append/-1001720160 var504 var1213)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var504!1 String)
(assert (str.prefixof var504 var504!1))
(assert true)
(define-const var3063 String (append/672562846 var3102 ", widx=")) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", widx=") 
(declare-const var3102!1 String)
(assert (= var3102!1 (str.++ var3102 ", widx=")))
(define-const var2082 Int (writerIndex/-1127548904 var2965)) ; Statement: $i1 = r1.<org.apache.dubbo.remoting.buffer.AbstractChannelBuffer: int writerIndex> 
(assert true)
(define-const var283 String (append/-1001720160 var3063 var2082)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i1) 
(declare-const var3063!1 String)
(assert (str.prefixof var3063 var3063!1))
(assert true)
(define-const var2437 String (append/672562846 var283 ", cap=")) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cap=") 
(declare-const var283!1 String)
(assert (= var283!1 (str.++ var283 ", cap=")))
(assert true)
(define-const var1921 Int (capacity/1290500406 (cast-from-var3375-to-var591 var2965))) ; Statement: $i2 = virtualinvoke r1.<org.apache.dubbo.remoting.buffer.AbstractChannelBuffer: int capacity()>() 
(assert true)
(define-const var3219 String (append/-1001720160 var2437 var1921)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i2) 
(declare-const var2437!1 String)
(assert (str.prefixof var2437 var2437!1))
(assert true)
(define-const var1295 String (append/-1166366385 var3219 41)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41) 
(declare-const var3219!1 String)
(assert (str.prefixof var3219 var3219!1))
(assert true)
(define-const var3454 String (toString/-2075883882 var1295)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r13 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-var3375-to-var2319=([org.apache.dubbo.remoting.buffer.AbstractChannelBuffer], java.lang.Object), getSimpleName/-390194377=([java.lang.Class], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), readerIndex/-1127548904=([org.apache.dubbo.remoting.buffer.AbstractChannelBuffer], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), writerIndex/-1127548904=([org.apache.dubbo.remoting.buffer.AbstractChannelBuffer], int), capacity/1290500406=([org.apache.dubbo.remoting.buffer.ChannelBuffer], int), cast-from-var3375-to-var591=([org.apache.dubbo.remoting.buffer.AbstractChannelBuffer], org.apache.dubbo.remoting.buffer.ChannelBuffer), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3375=org.apache.dubbo.remoting.buffer.AbstractChannelBuffer, var2965=r1, var2721=$r0, var2319=java.lang.Object, var812=$r2, var3379=$r3, var2906=$r4, var512=$r5, var504=$r6, var1213=$i0, var3102=$r7, var3063=$r8, var2082=$i1, var283=$r9, var2437=$r10, var591=org.apache.dubbo.remoting.buffer.ChannelBuffer, var1921=$i2, var3219=$r11, var1295=$r12, var3454=$r13}
; {org.apache.dubbo.remoting.buffer.AbstractChannelBuffer=var3375, r1=var2965, $r0=var2721, java.lang.Object=var2319, $r2=var812, $r3=var3379, $r4=var2906, $r5=var512, $r6=var504, $i0=var1213, $r7=var3102, $r8=var3063, $i1=var2082, $r9=var283, $r10=var2437, org.apache.dubbo.remoting.buffer.ChannelBuffer=var591, $i2=var1921, $r11=var3219, $r12=var1295, $r13=var3454}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.remoting.buffer.AbstractChannelBuffer;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke r1.<java.lang.Object: java.lang.Class getClass()>();	$r3 = virtualinvoke $r2.<java.lang.Class: java.lang.String getSimpleName()>();	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ridx=");	$i0 = r1.<org.apache.dubbo.remoting.buffer.AbstractChannelBuffer: int readerIndex>;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", widx=");	$i1 = r1.<org.apache.dubbo.remoting.buffer.AbstractChannelBuffer: int writerIndex>;	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i1);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cap=");	$i2 = virtualinvoke r1.<org.apache.dubbo.remoting.buffer.AbstractChannelBuffer: int capacity()>();	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i2);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41);	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>();	return $r13
;block_num 1