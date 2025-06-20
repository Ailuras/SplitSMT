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

(declare-sort var2968 0)
(declare-sort var1197 0)
(declare-sort var1692 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-Int-init () (Array Int Int))
(declare-fun is/107231720 (var2968) var1197)
(declare-fun read/-661881266 (var1197 (Array Int Int) Int Int) Int)
(declare-fun var1692-init () var1692)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var1692 String) void)
(declare-const null-var2968 var2968)
(declare-const var2237 var2968) ; Statement: r1 := @this: org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput 
(assert (not (= var2237 null-var2968)))
(define-const var454 (Array Int Int) arr-Int-init) ; Statement: r0 = newarray (byte)[4] 
(define-const var3917 var1197 (is/107231720 var2237)) ; Statement: $r2 = r1.<org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput: java.io.InputStream is> 
(assert true)
(define-const var240 Int (read/-661881266 var3917 var454 0 4)) ; Statement: i0 = virtualinvoke $r2.<java.io.InputStream: int read(byte[],int,int)>(r0, 0, 4) 
 ; Statement: if i0 == 4 goto i5 = 0 
(assert (not (= var240 4))) ; Negate: Cond: i0 == 4  
(define-const var1722 var1692 var1692-init) ; Statement: $r9 = new java.lang.IllegalArgumentException 
(define-const var3355 String String-init) ; Statement: $r8 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3355)) ; Statement: specialinvoke $r8.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3355!1 String)
(assert (= var3355!1 ""))
(assert true)
(define-const var379 String (append/672562846 var3355!1 "deserialize failed. expected read length: 4 but actual read: ")) ; Statement: $r5 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("deserialize failed. expected read length: 4 but actual read: ") 
(declare-const var3355!2 String)
(assert (= var3355!2 (str.++ var3355!1 "deserialize failed. expected read length: 4 but actual read: ")))
(assert true)
(define-const var2327 String (append/-1001720160 var379 var240)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var379!1 String)
(assert (str.prefixof var379 var379!1))
(assert true)
(define-const var3611 String (toString/-2075883882 var2327)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var1722 var3611)) ; Statement: specialinvoke $r9.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r7) 

(declare-const var1722!1 var1692)
(declare-const var3611!1 String)
 ; Statement: throw $r9 
(check-sat)
; {arr-Int-init=([], byte[]), is/107231720=([org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput], java.io.InputStream), read/-661881266=([java.io.InputStream, byte[], int, int], int), var1692-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var2968=org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput, var2237=r1, var454=r0, var1197=java.io.InputStream, var3917=$r2, var240=i0, var1692=java.lang.IllegalArgumentException, var1722=$r9, var3355=$r8, var379=$r5, var2327=$r6, var3611=$r7}
; {org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput=var2968, r1=var2237, r0=var454, java.io.InputStream=var1197, $r2=var3917, i0=var240, java.lang.IllegalArgumentException=var1692, $r9=var1722, $r8=var3355, $r5=var379, $r6=var2327, $r7=var3611}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput;	r0 = newarray (byte)[4];	$r2 = r1.<org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput: java.io.InputStream is>;	i0 = virtualinvoke $r2.<java.io.InputStream: int read(byte[],int,int)>(r0, 0, 4);	if i0 == 4 goto i5 = 0;	$r9 = new java.lang.IllegalArgumentException;	$r8 = new java.lang.StringBuilder;	specialinvoke $r8.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("deserialize failed. expected read length: 4 but actual read: ");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r9.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r7);	throw $r9
;block_num 2