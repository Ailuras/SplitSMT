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

(declare-sort var146 0)
(declare-sort var3921 0)
(declare-sort var64 0)
(declare-sort var722 0)
(declare-sort var98 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var64-init () var64)
(declare-fun <init>/435258078 (var64) void)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun write/-583041360 (var64 String) void)
(declare-fun var722-init () var722)
(declare-fun <init>/-1864438596 (var722 var98) void)
(declare-fun cast-from-var64-to-var98 (var64) var98)
(declare-fun close/2116439267 (var722) void)
(declare-const null-String String)
(declare-const null-var3921 var3921)
(declare-const var1452 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var1452 null-String)))
(declare-const var2266 var3921) ; Statement: r7 := @parameter1: java.lang.Throwable 
(assert (not (= var2266 null-var3921)))
(define-const var3518 var64 var64-init) ; Statement: $r0 = new org.apache.dubbo.common.io.UnsafeStringWriter 
(assert true)
;(assert (<init>/435258078 var3518)) ; Statement: specialinvoke $r0.<org.apache.dubbo.common.io.UnsafeStringWriter: void <init>()>() 

(declare-const var3518!1 var64)
(define-const var1538 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1538)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1538!1 String)
(assert (= var1538!1 ""))
(assert true)
(define-const var2897 String (append/672562846 var1538!1 var1452)) ; Statement: $r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var1538!2 String)
(assert (= var1538!2 (str.++ var1538!1 var1452)))
(assert true)
(define-const var2186 String (append/672562846 var2897 "\n")) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n") 
(declare-const var2897!1 String)
(assert (= var2897!1 (str.++ var2897 "\n")))
(assert true)
(define-const var1471 String (toString/-2075883882 var2186)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (write/-583041360 var3518!1 var1471)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.common.io.UnsafeStringWriter: void write(java.lang.String)>($r5) 

(declare-const var3518!2 var64)
(declare-const var1471!1 String)
(define-const var2346 var722 var722-init) ; Statement: $r6 = new java.io.PrintWriter 
(assert true)
;(assert (<init>/-1864438596 var2346 (cast-from-var64-to-var98 var3518!2))) ; Statement: specialinvoke $r6.<java.io.PrintWriter: void <init>(java.io.Writer)>($r0) 

(declare-const var2346!1 var722)
(declare-const var3518!3 var64)
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var1123 var3921) ; Statement: $r9 := @caughtexception 
(assert (not (= var1123 null-var3921)))
(assert true) ; Non Conditional
(assert true)
;(assert (close/2116439267 var2346!1)) ; Statement: virtualinvoke $r6.<java.io.PrintWriter: void close()>() 

(declare-const var2346!2 var722)
 ; Statement: throw $r9 
(check-sat)
; {var64-init=([], org.apache.dubbo.common.io.UnsafeStringWriter), <init>/435258078=([org.apache.dubbo.common.io.UnsafeStringWriter], void), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), write/-583041360=([org.apache.dubbo.common.io.UnsafeStringWriter, java.lang.String], void), var722-init=([], java.io.PrintWriter), <init>/-1864438596=([java.io.PrintWriter, java.io.Writer], void), cast-from-var64-to-var98=([org.apache.dubbo.common.io.UnsafeStringWriter], java.io.Writer), close/2116439267=([java.io.PrintWriter], void)}
; {var1452=r2, var146=null_type, var3921=java.lang.Throwable, var2266=r7, var64=org.apache.dubbo.common.io.UnsafeStringWriter, var3518=$r0, var1538=$r1, var2897=$r3, var2186=$r4, var1471=$r5, var722=java.io.PrintWriter, var2346=$r6, var98=java.io.Writer, var1123=$r9}
; {r2=var1452, null_type=var146, java.lang.Throwable=var3921, r7=var2266, org.apache.dubbo.common.io.UnsafeStringWriter=var64, $r0=var3518, $r1=var1538, $r3=var2897, $r4=var2186, $r5=var1471, java.io.PrintWriter=var722, $r6=var2346, java.io.Writer=var98, $r9=var1123}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r2 := @parameter0: java.lang.String;	r7 := @parameter1: java.lang.Throwable;	$r0 = new org.apache.dubbo.common.io.UnsafeStringWriter;	specialinvoke $r0.<org.apache.dubbo.common.io.UnsafeStringWriter: void <init>()>();	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n");	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>();	virtualinvoke $r0.<org.apache.dubbo.common.io.UnsafeStringWriter: void write(java.lang.String)>($r5);	$r6 = new java.io.PrintWriter;	specialinvoke $r6.<java.io.PrintWriter: void <init>(java.io.Writer)>($r0);	$r9 := @caughtexception;	virtualinvoke $r6.<java.io.PrintWriter: void close()>();	throw $r9
;block_num 3