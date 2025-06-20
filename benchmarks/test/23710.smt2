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

(declare-sort var1828 0)
(declare-sort var3023 0)
(declare-sort var1134 0)
(declare-sort var268 0)
(declare-sort var246 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(declare-fun <init>/543593434 (String Int) void)
(declare-fun var3023_unwrap/-399275170 (var1828) var1828)
(declare-fun getMessage/849299655 (var1828) String)
(declare-fun getClass/1258963082 (var268) ClassObject)
(declare-fun cast-from-var1828-to-var268 (var1828) var268)
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getCause/-638798464 (var1828) var1828)
(declare-fun getStackTrace/1942967699 (var1828) (Array Int var246))
(declare-fun getLength-Arr-var246-1 ((Array Int var246)) Int)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1828 var1828)
(declare-const null-String String)
(declare-const var2827 var1828) ; Statement: r11 := @parameter0: java.lang.Throwable 
(assert (not (= var2827 null-var1828)))
(define-const var3260 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/543593434 var3260 256)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>(int)>(256) 

(declare-const var3260!1 String)
(declare-const var1486 Int)
(define-const var2175 var1828 (var3023_unwrap/-399275170 var2827)) ; Statement: r12 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.ExceptionUtils: java.lang.Throwable unwrap(java.lang.Throwable)>(r11) 
(define-const var1576 String null-String) ; Statement: r13 = null 
(assert true) ; Non Conditional
(assert true)
(define-const var1952 String (getMessage/849299655 var2175)) ; Statement: $r8 = virtualinvoke r12.<java.lang.Throwable: java.lang.String getMessage()>() 
(assert true)
(define-const var1637 ClassObject (getClass/1258963082 (cast-from-var1828-to-var268 var2175))) ; Statement: $r1 = virtualinvoke r12.<java.lang.Object: java.lang.Class getClass()>() 
(assert true)
(define-const var1882 String (getName/-1958580599 var1637)) ; Statement: $r9 = virtualinvoke $r1.<java.lang.Class: java.lang.String getName()>() 
 ; Statement: if r13 == null goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9) 
(assert (= var1576 null-String)) ; Cond: r13 == null 
(assert true)
;(assert (append/672562846 var3260!1 var1882)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9) 
(declare-const var3260!2 String)
(assert (= var3260!2 (str.++ var3260!1 var1882)))
(define-const var1576!1 String var1952) ; Statement: r13 = $r8 
(define-const var3709 var1828 var2175) ; Statement: r2 = r12 
(assert true)
(define-const var228 var1828 (getCause/-638798464 var2175)) ; Statement: $r14 = virtualinvoke r12.<java.lang.Throwable: java.lang.Throwable getCause()>() 
(define-const var2175!1 var1828 var228) ; Statement: r12 = $r14 
 ; Statement: if $r14 == null goto (branch) 
(assert (= var228 null-var1828)) ; Cond: $r14 == null 
 ; Statement: if $r8 == null goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n -> Stack traces:") 
(assert (= var1952 null-String)) ; Cond: $r8 == null 
(assert true)
;(assert (append/672562846 var3260!2 "\n -> Stack traces:")) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n -> Stack traces:") 
(declare-const var3260!3 String)
(assert (= var3260!3 (str.++ var3260!2 "\n -> Stack traces:")))
(assert true)
(define-const var1844 (Array Int var246) (getStackTrace/1942967699 var3709)) ; Statement: $r7 = virtualinvoke r2.<java.lang.Throwable: java.lang.StackTraceElement[] getStackTrace()>() 
(define-const var3652 Int 0) ; Statement: i1 = 0 
(define-const var1964 Int (getLength-Arr-var246-1 var1844)) ; Statement: $i0 = lengthof $r7 
(assert true) ; Non Conditional
 ; Statement: if i1 >= 10 goto $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (>= var3652 10)) ; Cond: i1 >= 10 
(assert true)
(define-const var3999 String (toString/-2075883882 var3260!3)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r3 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/543593434=([java.lang.StringBuilder, int], void), var3023_unwrap/-399275170=([java.lang.Throwable], java.lang.Throwable), getMessage/849299655=([java.lang.Throwable], java.lang.String), getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-var1828-to-var268=([java.lang.Throwable], java.lang.Object), getName/-1958580599=([java.lang.Class], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getCause/-638798464=([java.lang.Throwable], java.lang.Throwable), getStackTrace/1942967699=([java.lang.Throwable], java.lang.StackTraceElement[]), getLength-Arr-var246-1=([java.lang.StackTraceElement[]], int), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1828=java.lang.Throwable, var2827=r11, var3260=$r0, var1486=256, var3023=org.apache.dubbo.rpc.protocol.tri.ExceptionUtils, var2175=r12, var1134=null_type, var1576=r13, var1952=$r8, var268=java.lang.Object, var1637=$r1, var1882=$r9, var3709=r2, var228=$r14, var246=java.lang.StackTraceElement, var1844=$r7, var3652=i1, var1964=$i0, var3999=$r3}
; {java.lang.Throwable=var1828, r11=var2827, $r0=var3260, 256=var1486, org.apache.dubbo.rpc.protocol.tri.ExceptionUtils=var3023, r12=var2175, null_type=var1134, r13=var1576, $r8=var1952, java.lang.Object=var268, $r1=var1637, $r9=var1882, r2=var3709, $r14=var228, java.lang.StackTraceElement=var246, $r7=var1844, i1=var3652, $i0=var1964, $r3=var3999}
;seq <java.lang.StringBuilder: void <init>(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>(int)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r11 := @parameter0: java.lang.Throwable;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>(int)>(256);	r12 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.ExceptionUtils: java.lang.Throwable unwrap(java.lang.Throwable)>(r11);	r13 = null;	$r8 = virtualinvoke r12.<java.lang.Throwable: java.lang.String getMessage()>();	$r1 = virtualinvoke r12.<java.lang.Object: java.lang.Class getClass()>();	$r9 = virtualinvoke $r1.<java.lang.Class: java.lang.String getName()>();	if r13 == null goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9);	r13 = $r8;	r2 = r12;	$r14 = virtualinvoke r12.<java.lang.Throwable: java.lang.Throwable getCause()>();	r12 = $r14;	if $r14 == null goto (branch);	if $r8 == null goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n -> Stack traces:");	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n -> Stack traces:");	$r7 = virtualinvoke r2.<java.lang.Throwable: java.lang.StackTraceElement[] getStackTrace()>();	i1 = 0;	$i0 = lengthof $r7;	if i1 >= 10 goto $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r3
;block_num 7