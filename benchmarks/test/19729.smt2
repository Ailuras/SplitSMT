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

(declare-sort var2211 0)
(declare-sort var1153 0)
(declare-sort var356 0)
(declare-sort var1631 0)
(declare-sort var1540 0)
(declare-sort var1674 0)
(declare-sort var481 0)
(declare-sort var2162 0)
(declare-sort var2351 0)
(declare-sort var1422 0)
(declare-sort var846 0)
(declare-sort var3387 0)
(declare-sort var1683 0)
(declare-sort var3843 0)
(declare-sort var502 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1540_isDebugEnabled/-823448366 (var1540) Bool)
(declare-fun cast-from-var1631-to-var1540 (var1631) var1540)
(declare-fun available/868489661 (var356) Int)
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun setAttribute/-1111333288 (var1674 String var481) void)
(declare-fun cast-from-var2211-to-var1674 (var2211) var1674)
(declare-fun cast-from-Int-to-var481 (Int) var481)
(declare-fun invocation/-856552381 (var2211) var2162)
(declare-fun serializationType/-856552381 (var2211) Int)
(declare-fun Int_valueOf/-1256543613 (Int) Int)
(declare-fun var1422_getSerialization/945999231 (Int) var2351)
(declare-fun var3387_getUrl/938756954 (var3387) var846)
(declare-fun cast-from-var1153-to-var3387 (var1153) var3387)
(declare-fun var2351_deserialize/-1267248335 (var2351 var846 var356) var1683)
(declare-fun var3843_readByte/546407046 (var3843) Int)
(declare-fun cast-from-var1683-to-var3843 (var1683) var3843)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun var502-init () var502)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1557872005 (var502 String) void)
(declare-const null-var2211 var2211)
(declare-const null-var1153 var1153)
(declare-const null-var356 var356)
(declare-const var2211-log var1631)
(declare-const null-var2162 var2162)
(declare-const var1041 var2211) ; Statement: r2 := @this: org.apache.dubbo.rpc.protocol.dubbo.DecodeableRpcResult 
(assert (not (= var1041 null-var2211)))
(declare-const var3915 var1153) ; Statement: r5 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var3915 null-var1153)))
(declare-const var2286 var356) ; Statement: r1 := @parameter1: java.io.InputStream 
(assert (not (= var2286 null-var356)))
(define-const var3375 var1631 var2211-log) ; Statement: $r0 = <org.apache.dubbo.rpc.protocol.dubbo.DecodeableRpcResult: org.apache.dubbo.common.logger.ErrorTypeAwareLogger log> 
(define-const var2011 Bool (var1540_isDebugEnabled/-823448366 (cast-from-var1631-to-var1540 var3375))) ; Statement: $z0 = interfaceinvoke $r0.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isDebugEnabled()>() 
 ; Statement: if $z0 == 0 goto $i1 = virtualinvoke r1.<java.io.InputStream: int available()>() 
(assert (= (ite var2011 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var3342 Int (available/868489661 var2286)) ; Statement: $i1 = virtualinvoke r1.<java.io.InputStream: int available()>() 
(define-const var1739 Int (Int_valueOf/-1371140006 var3342)) ; Statement: $r3 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>($i1) 
(assert true)
;(assert (setAttribute/-1111333288 (cast-from-var2211-to-var1674 var1041) "content-length" (cast-from-Int-to-var481 var1739))) ; Statement: virtualinvoke r2.<org.apache.dubbo.rpc.protocol.dubbo.DecodeableRpcResult: void setAttribute(java.lang.String,java.lang.Object)>("content-length", $r3) 

(declare-const var1041!1 var2211)
(declare-const var1661 String)
(declare-const var1739!1 Int)
(define-const var230 var2162 (invocation/-856552381 var1041!1)) ; Statement: $r4 = r2.<org.apache.dubbo.rpc.protocol.dubbo.DecodeableRpcResult: org.apache.dubbo.rpc.Invocation invocation> 
 ; Statement: if $r4 == null goto $b2 = r2.<org.apache.dubbo.rpc.protocol.dubbo.DecodeableRpcResult: byte serializationType> 
(assert (= var230 null-var2162)) ; Cond: $r4 == null 
(define-const var682 Int (serializationType/-856552381 var1041!1)) ; Statement: $b2 = r2.<org.apache.dubbo.rpc.protocol.dubbo.DecodeableRpcResult: byte serializationType> 
(define-const var224 Int (Int_valueOf/-1256543613 var682)) ; Statement: $r28 = staticinvoke <java.lang.Byte: java.lang.Byte valueOf(byte)>($b2) 
(define-const var3875 var2351 (var1422_getSerialization/945999231 var224)) ; Statement: $r29 = staticinvoke <org.apache.dubbo.remoting.transport.CodecSupport: org.apache.dubbo.common.serialize.Serialization getSerialization(java.lang.Byte)>($r28) 
(define-const var3656 var846 (var3387_getUrl/938756954 (cast-from-var1153-to-var3387 var3915))) ; Statement: $r30 = interfaceinvoke r5.<org.apache.dubbo.remoting.Channel: org.apache.dubbo.common.URL getUrl()>() 
(define-const var1823 var1683 (var2351_deserialize/-1267248335 var3875 var3656 var2286)) ; Statement: $r31 = interfaceinvoke $r29.<org.apache.dubbo.common.serialize.Serialization: org.apache.dubbo.common.serialize.ObjectInput deserialize(org.apache.dubbo.common.URL,java.io.InputStream)>($r30, r1) 
(define-const var2164 Int (var3843_readByte/546407046 (cast-from-var1683-to-var3843 var1823))) ; Statement: $b3 = interfaceinvoke $r31.<org.apache.dubbo.common.serialize.ObjectInput: byte readByte()>() 
(define-const var2279 Int (cast-from-Int-to-Int var2164)) ; Statement: $i4 = (int) $b3 
 ; Statement: tableswitch($i4) {     case 0: goto specialinvoke r2.<org.apache.dubbo.rpc.protocol.dubbo.DecodeableRpcResult: void handleException(org.apache.dubbo.common.serialize.ObjectInput)>($r31);     case 1: goto specialinvoke r2.<org.apache.dubbo.rpc.protocol.dubbo.DecodeableRpcResult: void handleValue(org.apache.dubbo.common.serialize.ObjectInput)>($r31);     case 2: goto goto [?= $z1 = $r31 instanceof org.apache.dubbo.common.serialize.Cleanable];     case 3: goto specialinvoke r2.<org.apache.dubbo.rpc.protocol.dubbo.DecodeableRpcResult: void handleException(org.apache.dubbo.common.serialize.ObjectInput)>($r31);     case 4: goto specialinvoke r2.<org.apache.dubbo.rpc.protocol.dubbo.DecodeableRpcResult: void handleValue(org.apache.dubbo.common.serialize.ObjectInput)>($r31);     case 5: goto specialinvoke r2.<org.apache.dubbo.rpc.protocol.dubbo.DecodeableRpcResult: void handleAttachment(org.apache.dubbo.common.serialize.ObjectInput)>($r31);     default: goto $r34 = new java.io.IOException; } 
(assert (and (not (= var2279 5)) (and (not (= var2279 4)) (and (not (= var2279 3)) (and (not (= var2279 2)) (and (not (= var2279 1)) (and (not (= var2279 0)) true))))))) ; Intersect: Negate: Cond: $i4 == 5   and Intersect: Negate: Cond: $i4 == 4   and Intersect: Negate: Cond: $i4 == 3   and Intersect: Negate: Cond: $i4 == 2   and Intersect: Negate: Cond: $i4 == 1   and Intersect: Negate: Cond: $i4 == 0   and Non Conditional      
(define-const var1458 var502 var502-init) ; Statement: $r34 = new java.io.IOException 
(define-const var2271 String String-init) ; Statement: $r33 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2271)) ; Statement: specialinvoke $r33.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2271!1 String)
(assert (= var2271!1 ""))
(assert true)
(define-const var2745 String (append/672562846 var2271!1 "Unknown result flag, expect \u00270\u0027 \u00271\u0027 \u00272\u0027 \u00273\u0027 \u00274\u0027 \u00275\u0027, but received: ")) ; Statement: $r9 = virtualinvoke $r33.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Unknown result flag, expect \'0\' \'1\' \'2\' \'3\' \'4\' \'5\', but received: ") 
(declare-const var2271!2 String)
(assert (= var2271!2 (str.++ var2271!1 "Unknown result flag, expect \u00270\u0027 \u00271\u0027 \u00272\u0027 \u00273\u0027 \u00274\u0027 \u00275\u0027, but received: ")))
(define-const var1715 Int (cast-from-Int-to-Int var2164)) ; Statement: $i5 = (int) $b3 
(assert true)
(define-const var2349 String (append/-1001720160 var2745 var1715)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i5) 
(declare-const var2745!1 String)
(assert (str.prefixof var2745 var2745!1))
(assert true)
(define-const var3463 String (toString/-2075883882 var2349)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1557872005 var1458 var3463)) ; Statement: specialinvoke $r34.<java.io.IOException: void <init>(java.lang.String)>($r11) 

(declare-const var1458!1 var502)
(declare-const var3463!1 String)
 ; Statement: throw $r34 
(check-sat)
; {var1540_isDebugEnabled/-823448366=([org.apache.dubbo.common.logger.Logger], boolean), cast-from-var1631-to-var1540=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), available/868489661=([java.io.InputStream], int), Int_valueOf/-1371140006=([int], java.lang.Integer), setAttribute/-1111333288=([org.apache.dubbo.rpc.AppResponse, java.lang.String, java.lang.Object], void), cast-from-var2211-to-var1674=([org.apache.dubbo.rpc.protocol.dubbo.DecodeableRpcResult], org.apache.dubbo.rpc.AppResponse), cast-from-Int-to-var481=([java.lang.Integer], java.lang.Object), invocation/-856552381=([org.apache.dubbo.rpc.protocol.dubbo.DecodeableRpcResult], org.apache.dubbo.rpc.Invocation), serializationType/-856552381=([org.apache.dubbo.rpc.protocol.dubbo.DecodeableRpcResult], byte), Int_valueOf/-1256543613=([byte], java.lang.Byte), var1422_getSerialization/945999231=([java.lang.Byte], org.apache.dubbo.common.serialize.Serialization), var3387_getUrl/938756954=([org.apache.dubbo.remoting.Endpoint], org.apache.dubbo.common.URL), cast-from-var1153-to-var3387=([org.apache.dubbo.remoting.Channel], org.apache.dubbo.remoting.Endpoint), var2351_deserialize/-1267248335=([org.apache.dubbo.common.serialize.Serialization, org.apache.dubbo.common.URL, java.io.InputStream], org.apache.dubbo.common.serialize.ObjectInput), var3843_readByte/546407046=([org.apache.dubbo.common.serialize.DataInput], byte), cast-from-var1683-to-var3843=([org.apache.dubbo.common.serialize.ObjectInput], org.apache.dubbo.common.serialize.DataInput), cast-from-Int-to-Int=([byte], int), var502-init=([], java.io.IOException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1557872005=([java.io.IOException, java.lang.String], void)}
; {var2211=org.apache.dubbo.rpc.protocol.dubbo.DecodeableRpcResult, var1041=r2, var1153=org.apache.dubbo.remoting.Channel, var3915=r5, var356=java.io.InputStream, var2286=r1, var1631=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3375=$r0, var1540=org.apache.dubbo.common.logger.Logger, var2011=$z0, var3342=$i1, var1739=$r3, var1674=org.apache.dubbo.rpc.AppResponse, var481=java.lang.Object, var1661="content-length", var2162=org.apache.dubbo.rpc.Invocation, var230=$r4, var682=$b2, var224=$r28, var2351=org.apache.dubbo.common.serialize.Serialization, var1422=org.apache.dubbo.remoting.transport.CodecSupport, var3875=$r29, var846=org.apache.dubbo.common.URL, var3387=org.apache.dubbo.remoting.Endpoint, var3656=$r30, var1683=org.apache.dubbo.common.serialize.ObjectInput, var1823=$r31, var3843=org.apache.dubbo.common.serialize.DataInput, var2164=$b3, var2279=$i4, var502=java.io.IOException, var1458=$r34, var2271=$r33, var2745=$r9, var1715=$i5, var2349=$r10, var3463=$r11}
; {org.apache.dubbo.rpc.protocol.dubbo.DecodeableRpcResult=var2211, r2=var1041, org.apache.dubbo.remoting.Channel=var1153, r5=var3915, java.io.InputStream=var356, r1=var2286, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var1631, $r0=var3375, org.apache.dubbo.common.logger.Logger=var1540, $z0=var2011, $i1=var3342, $r3=var1739, org.apache.dubbo.rpc.AppResponse=var1674, java.lang.Object=var481, "content-length"=var1661, org.apache.dubbo.rpc.Invocation=var2162, $r4=var230, $b2=var682, $r28=var224, org.apache.dubbo.common.serialize.Serialization=var2351, org.apache.dubbo.remoting.transport.CodecSupport=var1422, $r29=var3875, org.apache.dubbo.common.URL=var846, org.apache.dubbo.remoting.Endpoint=var3387, $r30=var3656, org.apache.dubbo.common.serialize.ObjectInput=var1683, $r31=var1823, org.apache.dubbo.common.serialize.DataInput=var3843, $b3=var2164, $i4=var2279, java.io.IOException=var502, $r34=var1458, $r33=var2271, $r9=var2745, $i5=var1715, $r10=var2349, $r11=var3463}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r2 := @this: org.apache.dubbo.rpc.protocol.dubbo.DecodeableRpcResult;	r5 := @parameter0: org.apache.dubbo.remoting.Channel;	r1 := @parameter1: java.io.InputStream;	$r0 = <org.apache.dubbo.rpc.protocol.dubbo.DecodeableRpcResult: org.apache.dubbo.common.logger.ErrorTypeAwareLogger log>;	$z0 = interfaceinvoke $r0.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isDebugEnabled()>();	if $z0 == 0 goto $i1 = virtualinvoke r1.<java.io.InputStream: int available()>();	$i1 = virtualinvoke r1.<java.io.InputStream: int available()>();	$r3 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>($i1);	virtualinvoke r2.<org.apache.dubbo.rpc.protocol.dubbo.DecodeableRpcResult: void setAttribute(java.lang.String,java.lang.Object)>("content-length", $r3);	$r4 = r2.<org.apache.dubbo.rpc.protocol.dubbo.DecodeableRpcResult: org.apache.dubbo.rpc.Invocation invocation>;	if $r4 == null goto $b2 = r2.<org.apache.dubbo.rpc.protocol.dubbo.DecodeableRpcResult: byte serializationType>;	$b2 = r2.<org.apache.dubbo.rpc.protocol.dubbo.DecodeableRpcResult: byte serializationType>;	$r28 = staticinvoke <java.lang.Byte: java.lang.Byte valueOf(byte)>($b2);	$r29 = staticinvoke <org.apache.dubbo.remoting.transport.CodecSupport: org.apache.dubbo.common.serialize.Serialization getSerialization(java.lang.Byte)>($r28);	$r30 = interfaceinvoke r5.<org.apache.dubbo.remoting.Channel: org.apache.dubbo.common.URL getUrl()>();	$r31 = interfaceinvoke $r29.<org.apache.dubbo.common.serialize.Serialization: org.apache.dubbo.common.serialize.ObjectInput deserialize(org.apache.dubbo.common.URL,java.io.InputStream)>($r30, r1);	$b3 = interfaceinvoke $r31.<org.apache.dubbo.common.serialize.ObjectInput: byte readByte()>();	$i4 = (int) $b3;	tableswitch($i4) {     case 0: goto specialinvoke r2.<org.apache.dubbo.rpc.protocol.dubbo.DecodeableRpcResult: void handleException(org.apache.dubbo.common.serialize.ObjectInput)>($r31);     case 1: goto specialinvoke r2.<org.apache.dubbo.rpc.protocol.dubbo.DecodeableRpcResult: void handleValue(org.apache.dubbo.common.serialize.ObjectInput)>($r31);     case 2: goto goto [?= $z1 = $r31 instanceof org.apache.dubbo.common.serialize.Cleanable];     case 3: goto specialinvoke r2.<org.apache.dubbo.rpc.protocol.dubbo.DecodeableRpcResult: void handleException(org.apache.dubbo.common.serialize.ObjectInput)>($r31);     case 4: goto specialinvoke r2.<org.apache.dubbo.rpc.protocol.dubbo.DecodeableRpcResult: void handleValue(org.apache.dubbo.common.serialize.ObjectInput)>($r31);     case 5: goto specialinvoke r2.<org.apache.dubbo.rpc.protocol.dubbo.DecodeableRpcResult: void handleAttachment(org.apache.dubbo.common.serialize.ObjectInput)>($r31);     default: goto $r34 = new java.io.IOException; };	$r34 = new java.io.IOException;	$r33 = new java.lang.StringBuilder;	specialinvoke $r33.<java.lang.StringBuilder: void <init>()>();	$r9 = virtualinvoke $r33.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Unknown result flag, expect \'0\' \'1\' \'2\' \'3\' \'4\' \'5\', but received: ");	$i5 = (int) $b3;	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i5);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r34.<java.io.IOException: void <init>(java.lang.String)>($r11);	throw $r34
;block_num 4