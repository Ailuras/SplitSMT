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

(declare-sort var2586 0)
(declare-sort var1806 0)
(declare-sort var630 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun length/1134182516 (var2586) Int)
(declare-fun var1806_isOutOfBounds/256325261 (Int Int Int) Bool)
(declare-fun var630-init () var630)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/1107025377 (var630 String) void)
(declare-const null-var2586 var2586)
(declare-const null-Int Int)
(declare-const var51 var2586) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.util.KeyString 
(assert (not (= var51 null-var2586)))
(declare-const var3628 Int) ; Statement: i1 := @parameter0: int 
(assert (not (= var3628 null-Int)))
(declare-const var3377 Int) ; Statement: i7 := @parameter1: int 
(assert (not (= var3377 null-Int)))
(define-const var1215 Int (length/1134182516 var51)) ; Statement: i0 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.util.KeyString: int length> 
 ; Statement: if i7 >= 0 goto $i2 = i7 - i1 
(assert (>= var3377 0)) ; Cond: i7 >= 0 
(define-const var3681 Int (- var3377 var3628)) ; Statement: $i2 = i7 - i1 
(define-const var2856 Bool (var1806_isOutOfBounds/256325261 var3628 var3681 var1215)) ; Statement: $z0 = staticinvoke <io.netty.util.internal.MathUtil: boolean isOutOfBounds(int,int,int)>(i1, $i2, i0) 
 ; Statement: if $z0 == 0 goto (branch) 
(assert (not (= (ite var2856 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var622 var630 var630-init) ; Statement: $r4 = new java.lang.IndexOutOfBoundsException 
(define-const var2537 String String-init) ; Statement: $r5 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2537)) ; Statement: specialinvoke $r5.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2537!1 String)
(assert (= var2537!1 ""))
(assert true)
(define-const var3481 String (append/672562846 var2537!1 "expected: 0 <= start(")) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("expected: 0 <= start(") 
(declare-const var2537!2 String)
(assert (= var2537!2 (str.++ var2537!1 "expected: 0 <= start(")))
(assert true)
(define-const var1214 String (append/-1001720160 var3481 var3628)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i1) 
(declare-const var3481!1 String)
(assert (str.prefixof var3481 var3481!1))
(assert true)
(define-const var222 String (append/672562846 var1214 ") <= end (")) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") <= end (") 
(declare-const var1214!1 String)
(assert (= var1214!1 (str.++ var1214 ") <= end (")))
(assert true)
(define-const var289 String (append/-1001720160 var222 var3377)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i7) 
(declare-const var222!1 String)
(assert (str.prefixof var222 var222!1))
(assert true)
(define-const var3120 String (append/672562846 var289 ") <= len(")) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") <= len(") 
(declare-const var289!1 String)
(assert (= var289!1 (str.++ var289 ") <= len(")))
(assert true)
(define-const var144 String (append/-1001720160 var3120 var1215)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var3120!1 String)
(assert (str.prefixof var3120 var3120!1))
(assert true)
(define-const var10 String (append/-1166366385 var144 41)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41) 
(declare-const var144!1 String)
(assert (str.prefixof var144 var144!1))
(assert true)
(define-const var2982 String (toString/-2075883882 var10)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/1107025377 var622 var2982)) ; Statement: specialinvoke $r4.<java.lang.IndexOutOfBoundsException: void <init>(java.lang.String)>($r13) 

(declare-const var622!1 var630)
(declare-const var2982!1 String)
 ; Statement: throw $r4 
(check-sat)
; {length/1134182516=([org.apache.dubbo.rpc.protocol.tri.rest.util.KeyString], int), var1806_isOutOfBounds/256325261=([int, int, int], boolean), var630-init=([], java.lang.IndexOutOfBoundsException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/1107025377=([java.lang.IndexOutOfBoundsException, java.lang.String], void)}
; {var2586=org.apache.dubbo.rpc.protocol.tri.rest.util.KeyString, var51=r0, var3628=i1, var3377=i7, var1215=i0, var3681=$i2, var1806=io.netty.util.internal.MathUtil, var2856=$z0, var630=java.lang.IndexOutOfBoundsException, var622=$r4, var2537=$r5, var3481=$r6, var1214=$r7, var222=$r8, var289=$r9, var3120=$r10, var144=$r11, var10=$r12, var2982=$r13}
; {org.apache.dubbo.rpc.protocol.tri.rest.util.KeyString=var2586, r0=var51, i1=var3628, i7=var3377, i0=var1215, $i2=var3681, io.netty.util.internal.MathUtil=var1806, $z0=var2856, java.lang.IndexOutOfBoundsException=var630, $r4=var622, $r5=var2537, $r6=var3481, $r7=var1214, $r8=var222, $r9=var289, $r10=var3120, $r11=var144, $r12=var10, $r13=var2982}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.util.KeyString;	i1 := @parameter0: int;	i7 := @parameter1: int;	i0 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.util.KeyString: int length>;	if i7 >= 0 goto $i2 = i7 - i1;	$i2 = i7 - i1;	$z0 = staticinvoke <io.netty.util.internal.MathUtil: boolean isOutOfBounds(int,int,int)>(i1, $i2, i0);	if $z0 == 0 goto (branch);	$r4 = new java.lang.IndexOutOfBoundsException;	$r5 = new java.lang.StringBuilder;	specialinvoke $r5.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("expected: 0 <= start(");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i1);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") <= end (");	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i7);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") <= len(");	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41);	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r4.<java.lang.IndexOutOfBoundsException: void <init>(java.lang.String)>($r13);	throw $r4
;block_num 3