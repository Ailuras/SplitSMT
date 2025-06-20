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

(declare-sort var155 0)
(declare-sort var1138 0)
(declare-sort var475 0)
(declare-sort var1896 0)
(declare-sort var2157 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1138_makeTag/1003755579 (Int Int) Int)
(declare-fun var1138_varIntEncode/-292263855 (Int) (Array Int Int))
(declare-fun serializeType/178387301 (var155) String)
(declare-fun getBytes/-163691139 (String var475) (Array Int Int))
(declare-fun getLength-Arr-Int-1 ((Array Int Int)) Int)
(declare-fun data/178387301 (var155) (Array Int Int))
(declare-fun type/178387301 (var155) String)
(declare-fun var2157_allocate/-517473021 (Int) var2157)
(declare-fun put/1397663458 (var2157 (Array Int Int)) var2157)
(declare-fun array/-1311260030 (var2157) (Array Int Int))
(declare-const null-var155 var155)
(declare-const var1896-UTF_8 var475)
(declare-const null-__Array__Int__Int__ (Array Int Int))
(declare-const var1285 var155) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper$TripleResponseWrapper 
(assert (not (= var1285 null-var155)))
(define-const var2235 Int (var1138_makeTag/1003755579 1 2)) ; Statement: i0 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper: int makeTag(int,int)>(1, 2) 
(define-const var317 (Array Int Int) (var1138_varIntEncode/-292263855 var2235)) ; Statement: r0 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper: byte[] varIntEncode(int)>(i0) 
(define-const var628 String (serializeType/178387301 var1285)) ; Statement: $r3 = r1.<org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper$TripleResponseWrapper: java.lang.String serializeType> 
(define-const var3393 var475 var1896-UTF_8) ; Statement: $r2 = <java.nio.charset.StandardCharsets: java.nio.charset.Charset UTF_8> 
(assert true)
(define-const var1766 (Array Int Int) (getBytes/-163691139 var628 var3393)) ; Statement: r4 = virtualinvoke $r3.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r2) 
(define-const var2958 Int (getLength-Arr-Int-1 var1766)) ; Statement: $i1 = lengthof r4 
(define-const var2995 (Array Int Int) (var1138_varIntEncode/-292263855 var2958)) ; Statement: r5 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper: byte[] varIntEncode(int)>($i1) 
(define-const var2896 Int (getLength-Arr-Int-1 var317)) ; Statement: $i3 = lengthof r0 
(define-const var1139 Int (getLength-Arr-Int-1 var2995)) ; Statement: $i2 = lengthof r5 
(define-const var2703 Int (+ var2896 var1139)) ; Statement: $i5 = $i3 + $i2 
(define-const var3389 Int (getLength-Arr-Int-1 var1766)) ; Statement: $i4 = lengthof r4 
(define-const var555 Int (+ var2703 var3389)) ; Statement: $i6 = $i5 + $i4 
(define-const var3217 Int (+ 0 var555)) ; Statement: i23 = 0 + $i6 
(define-const var3411 Int (var1138_makeTag/1003755579 2 2)) ; Statement: i7 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper: int makeTag(int,int)>(2, 2) 
(define-const var1314 (Array Int Int) (data/178387301 var1285)) ; Statement: $r6 = r1.<org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper$TripleResponseWrapper: byte[] data> 
 ; Statement: if $r6 == null goto $i21 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper: int makeTag(int,int)>(3, 2) 
(assert (= var1314 null-__Array__Int__Int__)) ; Cond: $r6 == null 
(define-const var1908 Int (var1138_makeTag/1003755579 3 2)) ; Statement: $i21 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper: int makeTag(int,int)>(3, 2) 
(define-const var3378 (Array Int Int) (var1138_varIntEncode/-292263855 var1908)) ; Statement: $r23 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper: byte[] varIntEncode(int)>($i21) 
(define-const var1893 String (type/178387301 var1285)) ; Statement: $r8 = r1.<org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper$TripleResponseWrapper: java.lang.String type> 
(define-const var2831 var475 var1896-UTF_8) ; Statement: $r7 = <java.nio.charset.StandardCharsets: java.nio.charset.Charset UTF_8> 
(assert true)
(define-const var3356 (Array Int Int) (getBytes/-163691139 var1893 var2831)) ; Statement: $r24 = virtualinvoke $r8.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r7) 
(define-const var3966 Int (getLength-Arr-Int-1 var3356)) ; Statement: $i8 = lengthof $r24 
(define-const var260 (Array Int Int) (var1138_varIntEncode/-292263855 var3966)) ; Statement: $r25 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper: byte[] varIntEncode(int)>($i8) 
(define-const var2646 Int (getLength-Arr-Int-1 var3378)) ; Statement: $i10 = lengthof $r23 
(define-const var3100 Int (getLength-Arr-Int-1 var260)) ; Statement: $i9 = lengthof $r25 
(define-const var2947 Int (+ var2646 var3100)) ; Statement: $i12 = $i10 + $i9 
(define-const var1373 Int (getLength-Arr-Int-1 var3356)) ; Statement: $i11 = lengthof $r24 
(define-const var587 Int (+ var2947 var1373)) ; Statement: $i13 = $i12 + $i11 
(define-const var3290 Int (+ var3217 var587)) ; Statement: $i22 = i23 + $i13 
(define-const var2660 var2157 (var2157_allocate/-517473021 var3290)) ; Statement: $r26 = staticinvoke <java.nio.ByteBuffer: java.nio.ByteBuffer allocate(int)>($i22) 
(assert true)
(define-const var3703 var2157 (put/1397663458 var2660 var317)) ; Statement: $r9 = virtualinvoke $r26.<java.nio.ByteBuffer: java.nio.ByteBuffer put(byte[])>(r0) 
(assert true)
(define-const var1759 var2157 (put/1397663458 var3703 var2995)) ; Statement: $r10 = virtualinvoke $r9.<java.nio.ByteBuffer: java.nio.ByteBuffer put(byte[])>(r5) 
(assert true)
;(assert (put/1397663458 var1759 var1766)) ; Statement: virtualinvoke $r10.<java.nio.ByteBuffer: java.nio.ByteBuffer put(byte[])>(r4) 

(declare-const var1759!1 var2157)
(declare-const var1766!1 (Array Int Int))
(define-const var2801 (Array Int Int) (data/178387301 var1285)) ; Statement: $r11 = r1.<org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper$TripleResponseWrapper: byte[] data> 
 ; Statement: if $r11 == null goto $r12 = virtualinvoke $r26.<java.nio.ByteBuffer: java.nio.ByteBuffer put(byte[])>($r23) 
(assert (= var2801 null-__Array__Int__Int__)) ; Cond: $r11 == null 
(assert true)
(define-const var1951 var2157 (put/1397663458 var2660 var3378)) ; Statement: $r12 = virtualinvoke $r26.<java.nio.ByteBuffer: java.nio.ByteBuffer put(byte[])>($r23) 
(assert true)
(define-const var2647 var2157 (put/1397663458 var1951 var260)) ; Statement: $r13 = virtualinvoke $r12.<java.nio.ByteBuffer: java.nio.ByteBuffer put(byte[])>($r25) 
(assert true)
;(assert (put/1397663458 var2647 var3356)) ; Statement: virtualinvoke $r13.<java.nio.ByteBuffer: java.nio.ByteBuffer put(byte[])>($r24) 

(declare-const var2647!1 var2157)
(declare-const var3356!1 (Array Int Int))
(assert true)
(define-const var2850 (Array Int Int) (array/-1311260030 var2660)) ; Statement: $r14 = virtualinvoke $r26.<java.nio.ByteBuffer: byte[] array()>() 
 ; Statement: return $r14 
(check-sat)
; {var1138_makeTag/1003755579=([int, int], int), var1138_varIntEncode/-292263855=([int], byte[]), serializeType/178387301=([org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper$TripleResponseWrapper], java.lang.String), getBytes/-163691139=([java.lang.String, java.nio.charset.Charset], byte[]), getLength-Arr-Int-1=([byte[]], int), data/178387301=([org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper$TripleResponseWrapper], byte[]), type/178387301=([org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper$TripleResponseWrapper], java.lang.String), var2157_allocate/-517473021=([int], java.nio.ByteBuffer), put/1397663458=([java.nio.ByteBuffer, byte[]], java.nio.ByteBuffer), array/-1311260030=([java.nio.ByteBuffer], byte[])}
; {var155=org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper$TripleResponseWrapper, var1285=r1, var1138=org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper, var2235=i0, var317=r0, var628=$r3, var475=java.nio.charset.Charset, var1896=java.nio.charset.StandardCharsets, var3393=$r2, var1766=r4, var2958=$i1, var2995=r5, var2896=$i3, var1139=$i2, var2703=$i5, var3389=$i4, var555=$i6, var3217=i23, var3411=i7, var1314=$r6, var1908=$i21, var3378=$r23, var1893=$r8, var2831=$r7, var3356=$r24, var3966=$i8, var260=$r25, var2646=$i10, var3100=$i9, var2947=$i12, var1373=$i11, var587=$i13, var3290=$i22, var2157=java.nio.ByteBuffer, var2660=$r26, var3703=$r9, var1759=$r10, var2801=$r11, var1951=$r12, var2647=$r13, var2850=$r14}
; {org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper$TripleResponseWrapper=var155, r1=var1285, org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper=var1138, i0=var2235, r0=var317, $r3=var628, java.nio.charset.Charset=var475, java.nio.charset.StandardCharsets=var1896, $r2=var3393, r4=var1766, $i1=var2958, r5=var2995, $i3=var2896, $i2=var1139, $i5=var2703, $i4=var3389, $i6=var555, i23=var3217, i7=var3411, $r6=var1314, $i21=var1908, $r23=var3378, $r8=var1893, $r7=var2831, $r24=var3356, $i8=var3966, $r25=var260, $i10=var2646, $i9=var3100, $i12=var2947, $i11=var1373, $i13=var587, $i22=var3290, java.nio.ByteBuffer=var2157, $r26=var2660, $r9=var3703, $r10=var1759, $r11=var2801, $r12=var1951, $r13=var2647, $r14=var2850}
;seq <java.lang.String: byte[] getBytes(java.nio.charset.Charset)>;	<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>
;cnt {"<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>": 2}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper$TripleResponseWrapper;	i0 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper: int makeTag(int,int)>(1, 2);	r0 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper: byte[] varIntEncode(int)>(i0);	$r3 = r1.<org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper$TripleResponseWrapper: java.lang.String serializeType>;	$r2 = <java.nio.charset.StandardCharsets: java.nio.charset.Charset UTF_8>;	r4 = virtualinvoke $r3.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r2);	$i1 = lengthof r4;	r5 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper: byte[] varIntEncode(int)>($i1);	$i3 = lengthof r0;	$i2 = lengthof r5;	$i5 = $i3 + $i2;	$i4 = lengthof r4;	$i6 = $i5 + $i4;	i23 = 0 + $i6;	i7 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper: int makeTag(int,int)>(2, 2);	$r6 = r1.<org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper$TripleResponseWrapper: byte[] data>;	if $r6 == null goto $i21 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper: int makeTag(int,int)>(3, 2);	$i21 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper: int makeTag(int,int)>(3, 2);	$r23 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper: byte[] varIntEncode(int)>($i21);	$r8 = r1.<org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper$TripleResponseWrapper: java.lang.String type>;	$r7 = <java.nio.charset.StandardCharsets: java.nio.charset.Charset UTF_8>;	$r24 = virtualinvoke $r8.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r7);	$i8 = lengthof $r24;	$r25 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper: byte[] varIntEncode(int)>($i8);	$i10 = lengthof $r23;	$i9 = lengthof $r25;	$i12 = $i10 + $i9;	$i11 = lengthof $r24;	$i13 = $i12 + $i11;	$i22 = i23 + $i13;	$r26 = staticinvoke <java.nio.ByteBuffer: java.nio.ByteBuffer allocate(int)>($i22);	$r9 = virtualinvoke $r26.<java.nio.ByteBuffer: java.nio.ByteBuffer put(byte[])>(r0);	$r10 = virtualinvoke $r9.<java.nio.ByteBuffer: java.nio.ByteBuffer put(byte[])>(r5);	virtualinvoke $r10.<java.nio.ByteBuffer: java.nio.ByteBuffer put(byte[])>(r4);	$r11 = r1.<org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper$TripleResponseWrapper: byte[] data>;	if $r11 == null goto $r12 = virtualinvoke $r26.<java.nio.ByteBuffer: java.nio.ByteBuffer put(byte[])>($r23);	$r12 = virtualinvoke $r26.<java.nio.ByteBuffer: java.nio.ByteBuffer put(byte[])>($r23);	$r13 = virtualinvoke $r12.<java.nio.ByteBuffer: java.nio.ByteBuffer put(byte[])>($r25);	virtualinvoke $r13.<java.nio.ByteBuffer: java.nio.ByteBuffer put(byte[])>($r24);	$r14 = virtualinvoke $r26.<java.nio.ByteBuffer: byte[] array()>();	return $r14
;block_num 3