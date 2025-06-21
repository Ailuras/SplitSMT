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

(declare-sort var1419 0)
(declare-sort var3123 0)
(declare-sort var784 0)
(declare-sort var3215 0)
(declare-sort var779 0)
(declare-sort var3329 0)
(declare-sort var3922 0)
(declare-sort var729 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3123_makeTag/1003755579 (Int Int) Int)
(declare-fun var3123_varIntEncode/-292263855 (Int) (Array Int Int))
(declare-fun serializeType/-879650735 (var1419) String)
(declare-fun getBytes/-163691139 (String var784) (Array Int Int))
(declare-fun getLength-Arr-Int-1 ((Array Int Int)) Int)
(declare-fun argTypes/-879650735 (var1419) var779)
(declare-fun var3329_isNotEmpty/-572947236 (var3922) Bool)
(declare-fun cast-from-var779-to-var3922 (var779) var3922)
(declare-fun args/-879650735 (var1419) var779)
(declare-fun var729_allocate/-517473021 (Int) var729)
(declare-fun put/1397663458 (var729 (Array Int Int)) var729)
(declare-fun array/-1311260030 (var729) (Array Int Int))
(declare-const null-var1419 var1419)
(declare-const var3215-UTF_8 var784)
(declare-const var2040 var1419) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper$TripleRequestWrapper 
(assert (not (= var2040 null-var1419)))
(define-const var805 Int (var3123_makeTag/1003755579 1 2)) ; Statement: i0 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper: int makeTag(int,int)>(1, 2) 
(define-const var3672 (Array Int Int) (var3123_varIntEncode/-292263855 var805)) ; Statement: r0 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper: byte[] varIntEncode(int)>(i0) 
(define-const var3961 String (serializeType/-879650735 var2040)) ; Statement: $r3 = r1.<org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper$TripleRequestWrapper: java.lang.String serializeType> 
(define-const var2493 var784 var3215-UTF_8) ; Statement: $r2 = <java.nio.charset.StandardCharsets: java.nio.charset.Charset UTF_8> 
(assert true)
(define-const var919 (Array Int Int) (getBytes/-163691139 var3961 var2493)) ; Statement: r4 = virtualinvoke $r3.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r2) 
(define-const var1388 Int (getLength-Arr-Int-1 var919)) ; Statement: $i1 = lengthof r4 
(define-const var1189 (Array Int Int) (var3123_varIntEncode/-292263855 var1388)) ; Statement: r5 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper: byte[] varIntEncode(int)>($i1) 
(define-const var1777 Int (getLength-Arr-Int-1 var3672)) ; Statement: $i3 = lengthof r0 
(define-const var578 Int (getLength-Arr-Int-1 var1189)) ; Statement: $i2 = lengthof r5 
(define-const var920 Int (+ var1777 var578)) ; Statement: $i5 = $i3 + $i2 
(define-const var331 Int (getLength-Arr-Int-1 var919)) ; Statement: $i4 = lengthof r4 
(define-const var686 Int (+ var920 var331)) ; Statement: $i6 = $i5 + $i4 
(define-const var1595 Int (+ 0 var686)) ; Statement: i25 = 0 + $i6 
(define-const var721 Int (var3123_makeTag/1003755579 3 2)) ; Statement: i7 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper: int makeTag(int,int)>(3, 2) 
(define-const var2098 var779 (argTypes/-879650735 var2040)) ; Statement: $r6 = r1.<org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper$TripleRequestWrapper: java.util.List argTypes> 
(define-const var820 Bool (var3329_isNotEmpty/-572947236 (cast-from-var779-to-var3922 var2098))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmpty(java.util.Collection)>($r6) 
 ; Statement: if $z0 == 0 goto $i20 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper: int makeTag(int,int)>(2, 2) 
(assert (= (ite var820 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3814 Int (var3123_makeTag/1003755579 2 2)) ; Statement: $i20 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper: int makeTag(int,int)>(2, 2) 
(define-const var2398 var779 (args/-879650735 var2040)) ; Statement: $r7 = r1.<org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper$TripleRequestWrapper: java.util.List args> 
(define-const var3577 Bool (var3329_isNotEmpty/-572947236 (cast-from-var779-to-var3922 var2398))) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmpty(java.util.Collection)>($r7) 
 ; Statement: if $z1 == 0 goto $r27 = staticinvoke <java.nio.ByteBuffer: java.nio.ByteBuffer allocate(int)>(i25) 
(assert (= (ite var3577 1 0) 0)) ; Cond: $z1 == 0 
(define-const var3891 var729 (var729_allocate/-517473021 var1595)) ; Statement: $r27 = staticinvoke <java.nio.ByteBuffer: java.nio.ByteBuffer allocate(int)>(i25) 
(assert true)
(define-const var2908 var729 (put/1397663458 var3891 var3672)) ; Statement: $r8 = virtualinvoke $r27.<java.nio.ByteBuffer: java.nio.ByteBuffer put(byte[])>(r0) 
(assert true)
(define-const var978 var729 (put/1397663458 var2908 var1189)) ; Statement: $r9 = virtualinvoke $r8.<java.nio.ByteBuffer: java.nio.ByteBuffer put(byte[])>(r5) 
(assert true)
;(assert (put/1397663458 var978 var919)) ; Statement: virtualinvoke $r9.<java.nio.ByteBuffer: java.nio.ByteBuffer put(byte[])>(r4) 

(declare-const var978!1 var729)
(declare-const var919!1 (Array Int Int))
(define-const var1391 var779 (args/-879650735 var2040)) ; Statement: $r10 = r1.<org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper$TripleRequestWrapper: java.util.List args> 
(define-const var3850 Bool (var3329_isNotEmpty/-572947236 (cast-from-var779-to-var3922 var1391))) ; Statement: $z2 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmpty(java.util.Collection)>($r10) 
 ; Statement: if $z2 == 0 goto $r11 = r1.<org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper$TripleRequestWrapper: java.util.List argTypes> 
(assert (= (ite var3850 1 0) 0)) ; Cond: $z2 == 0 
(define-const var657 var779 (argTypes/-879650735 var2040)) ; Statement: $r11 = r1.<org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper$TripleRequestWrapper: java.util.List argTypes> 
(define-const var1293 Bool (var3329_isNotEmpty/-572947236 (cast-from-var779-to-var3922 var657))) ; Statement: $z3 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmpty(java.util.Collection)>($r11) 
 ; Statement: if $z3 == 0 goto $r12 = virtualinvoke $r27.<java.nio.ByteBuffer: byte[] array()>() 
(assert (= (ite var1293 1 0) 0)) ; Cond: $z3 == 0 
(assert true)
(define-const var2627 (Array Int Int) (array/-1311260030 var3891)) ; Statement: $r12 = virtualinvoke $r27.<java.nio.ByteBuffer: byte[] array()>() 
 ; Statement: return $r12 
(check-sat)
; {var3123_makeTag/1003755579=([int, int], int), var3123_varIntEncode/-292263855=([int], byte[]), serializeType/-879650735=([org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper$TripleRequestWrapper], java.lang.String), getBytes/-163691139=([java.lang.String, java.nio.charset.Charset], byte[]), getLength-Arr-Int-1=([byte[]], int), argTypes/-879650735=([org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper$TripleRequestWrapper], java.util.List), var3329_isNotEmpty/-572947236=([java.util.Collection], boolean), cast-from-var779-to-var3922=([java.util.List], java.util.Collection), args/-879650735=([org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper$TripleRequestWrapper], java.util.List), var729_allocate/-517473021=([int], java.nio.ByteBuffer), put/1397663458=([java.nio.ByteBuffer, byte[]], java.nio.ByteBuffer), array/-1311260030=([java.nio.ByteBuffer], byte[])}
; {var1419=org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper$TripleRequestWrapper, var2040=r1, var3123=org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper, var805=i0, var3672=r0, var3961=$r3, var784=java.nio.charset.Charset, var3215=java.nio.charset.StandardCharsets, var2493=$r2, var919=r4, var1388=$i1, var1189=r5, var1777=$i3, var578=$i2, var920=$i5, var331=$i4, var686=$i6, var1595=i25, var721=i7, var779=java.util.List, var2098=$r6, var3329=org.apache.dubbo.common.utils.CollectionUtils, var3922=java.util.Collection, var820=$z0, var3814=$i20, var2398=$r7, var3577=$z1, var729=java.nio.ByteBuffer, var3891=$r27, var2908=$r8, var978=$r9, var1391=$r10, var3850=$z2, var657=$r11, var1293=$z3, var2627=$r12}
; {org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper$TripleRequestWrapper=var1419, r1=var2040, org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper=var3123, i0=var805, r0=var3672, $r3=var3961, java.nio.charset.Charset=var784, java.nio.charset.StandardCharsets=var3215, $r2=var2493, r4=var919, $i1=var1388, r5=var1189, $i3=var1777, $i2=var578, $i5=var920, $i4=var331, $i6=var686, i25=var1595, i7=var721, java.util.List=var779, $r6=var2098, org.apache.dubbo.common.utils.CollectionUtils=var3329, java.util.Collection=var3922, $z0=var820, $i20=var3814, $r7=var2398, $z1=var3577, java.nio.ByteBuffer=var729, $r27=var3891, $r8=var2908, $r9=var978, $r10=var1391, $z2=var3850, $r11=var657, $z3=var1293, $r12=var2627}
;seq <java.lang.String: byte[] getBytes(java.nio.charset.Charset)>
;cnt {"<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper$TripleRequestWrapper;	i0 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper: int makeTag(int,int)>(1, 2);	r0 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper: byte[] varIntEncode(int)>(i0);	$r3 = r1.<org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper$TripleRequestWrapper: java.lang.String serializeType>;	$r2 = <java.nio.charset.StandardCharsets: java.nio.charset.Charset UTF_8>;	r4 = virtualinvoke $r3.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r2);	$i1 = lengthof r4;	r5 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper: byte[] varIntEncode(int)>($i1);	$i3 = lengthof r0;	$i2 = lengthof r5;	$i5 = $i3 + $i2;	$i4 = lengthof r4;	$i6 = $i5 + $i4;	i25 = 0 + $i6;	i7 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper: int makeTag(int,int)>(3, 2);	$r6 = r1.<org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper$TripleRequestWrapper: java.util.List argTypes>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmpty(java.util.Collection)>($r6);	if $z0 == 0 goto $i20 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper: int makeTag(int,int)>(2, 2);	$i20 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper: int makeTag(int,int)>(2, 2);	$r7 = r1.<org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper$TripleRequestWrapper: java.util.List args>;	$z1 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmpty(java.util.Collection)>($r7);	if $z1 == 0 goto $r27 = staticinvoke <java.nio.ByteBuffer: java.nio.ByteBuffer allocate(int)>(i25);	$r27 = staticinvoke <java.nio.ByteBuffer: java.nio.ByteBuffer allocate(int)>(i25);	$r8 = virtualinvoke $r27.<java.nio.ByteBuffer: java.nio.ByteBuffer put(byte[])>(r0);	$r9 = virtualinvoke $r8.<java.nio.ByteBuffer: java.nio.ByteBuffer put(byte[])>(r5);	virtualinvoke $r9.<java.nio.ByteBuffer: java.nio.ByteBuffer put(byte[])>(r4);	$r10 = r1.<org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper$TripleRequestWrapper: java.util.List args>;	$z2 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmpty(java.util.Collection)>($r10);	if $z2 == 0 goto $r11 = r1.<org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper$TripleRequestWrapper: java.util.List argTypes>;	$r11 = r1.<org.apache.dubbo.rpc.protocol.tri.TripleCustomerProtocolWrapper$TripleRequestWrapper: java.util.List argTypes>;	$z3 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmpty(java.util.Collection)>($r11);	if $z3 == 0 goto $r12 = virtualinvoke $r27.<java.nio.ByteBuffer: byte[] array()>();	$r12 = virtualinvoke $r27.<java.nio.ByteBuffer: byte[] array()>();	return $r12
;block_num 5