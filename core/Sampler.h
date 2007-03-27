#ifndef __avmplus_Sampler__
#define __avmplus_Sampler__

/*
 * Copyright (C) 2004-2006 Adobe Macromedia Software LLC.  All rights reserved.
 */

namespace avmplus
{
#ifdef DEBUGGER
	struct Sample
	{
		uint64 micros;
		uint32 type;
		uint32 depth;
		void *trace;
		ClassClosure *allocType;
	};

	class Sampler
	{
	public:
		Sampler();
		~Sampler();

		enum SampleType 
		{ 
			RAW_SAMPLE=0x55555555,
			NEW_OBJECT_SAMPLE=0xaaaaaaaa, 
			DELETED_OBJECT_SAMPLE=0xdddddddd
		};
		
		// are we sampling at all
		bool sampling;

		// if true we call startSampling as early as possible during startup
		bool autoStartSampling;

		byte *getSamples(uint32 &num);
		
		void setCore(AvmCore *core) { this->core = core; }
		void init(bool sampling, bool autoStart);
		StackTrace *getStackTrace();
		void sampleCheck() { if(takeSample) sample(); }

		uint64 recordAllocationSample(AvmPlusScriptableObject *obj, Traits *t);
		void recordDeallocationSample(uint64 id);

		void startSampling();
		void stopSampling();
		void clearSamples();

		
		// called by VM after initBuiltin's
		void initSampling();

		AbstractFunction *createFakeFunction(const char *name);

		void presweep();
		void postsweep();

		StackTrace *getStackTrace(void/*StackTrace::Element*/ *e, int depth);

		void readRawSample(byte *&p, Sample &s);
		static void inline align(byte*&b)
		{
			if((int)b & 4)
			{
#ifdef DEBUG
				*(int32*)b = 0xaaaaaaaa;
#endif
				b += sizeof(int32);
			}
		}
		
		template<class T>
		static void inline read(byte *&p, T &u)
		{
			u = *(T*)p;
			p += sizeof(T);
		}

		template<class T>
		static void inline write(byte *&p, T u)
		{
			*(T*)p = u;
			p += sizeof(T);
		}
		
	private:	
		
		AvmCore *core;

		uint64 allocId;
				
		bool samplingNow;
		int takeSample;
		uint32 numSamples;
		GrowableBuffer *samples;
		byte *currentSample;
		void sample();

		uintptr timerHandle;
		Hashtable *fakeMethodInfos; 
		
		void rehashTraces(int newSize);
		int findTrace(void/*StackTrace::Element*/ *e, int depth);
		StackTrace **stackTraces;
		uint32 numTraces;

		// for fast Sample init
		int timeOffset;
		int stackOffset;
		
		void rewind(byte*&b, uint32 amount)
		{
			b -= amount;
		}

		void sampleSpaceCheck();
		
		void writeRawSample(SampleType sampleType);
		ScriptObject *buildSample(Toplevel *tl, uint64 ticks, String *trace);
	};

#define SAMPLE_FRAME(_strp, _core) avmplus::FakeCallStackNode __fcsn((avmplus::AvmCore*)_core, _strp)
#define SAMPLE_CHECK()  __fcsn.sampleCheck();

#else

#define SAMPLE_FRAME(_x, _s) 
#define SAMPLE_CHECK()

#endif // DEBUGGER
}
#endif // __avmplus_Sampler__
